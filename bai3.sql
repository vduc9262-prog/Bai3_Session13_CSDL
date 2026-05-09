create database bai3;

use bai3;

delimiter $$

create procedure sp_calculate_hospital_fee(
    in p_total_cost decimal(15,2),
    in p_patient_type varchar(20),
    out p_final_amount decimal(15,2),
    out p_message varchar(100)
)
begin
    -- kiểm tra chi phí hợp lệ
    if p_total_cost < 0 then
        set p_final_amount = 0;
        set p_message = 'lỗi: chi phí không hợp lệ';
    else
        -- tính toán theo diện bệnh nhân
        if p_patient_type = 'bhyt' then
            set p_final_amount = p_total_cost * 0.2;

        elseif p_patient_type = 'vip' then
            set p_final_amount = p_total_cost * 0.9;

        elseif p_patient_type = 'normal' then
            set p_final_amount = p_total_cost;

        else
            set p_final_amount = p_total_cost;
        end if;

        set p_message = 'đã tính toán xong';
    end if;
end $$

delimiter ;

set @amount = 0;
set @msg = '';

call sp_calculate_hospital_fee(1000000, 'bhyt', @amount, @msg);
select @amount as total_amount, @msg as message;

call sp_calculate_hospital_fee(1000000, 'vip', @amount, @msg);
select @amount as total_amount, @msg as message;

call sp_calculate_hospital_fee(1000000, 'normal', @amount, @msg);
select @amount as total_amount, @msg as message;

call sp_calculate_hospital_fee(-500000, 'vip', @amount, @msg);
select @amount as total_amount, @msg as message;