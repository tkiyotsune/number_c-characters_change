def n_change(number)
    begin
        # 英数字か漢数字か判断 true or false
        num_divide = !! (number =~ /[0-9]/)

        # 漢字->数字
        if num_divide === false

            # 単位と数字ごとに分けた配列を作成
            change_number = number.gsub(/[一|二|三|四|五|六|七|八|九]/,
            "一"=>",1","二"=>",2","三"=>",3","四"=>",4","五"=>",5","六"=>",6","七"=>",7","八"=>",8","九"=>",9")

            # 百十などの数字が頭にない場合は後付けでカンマを加える
            unless change_number.match(/[2-9]十/)
                change_number = change_number.gsub(/十/, ",十")
            end

            unless change_number.match(/[2-9]百/)
                change_number = change_number.gsub(/百/, ",百")
            end

            unless change_number.match(/[2-9]千/)
                change_number = change_number.gsub(/千/, ",千")
            end

            #  先頭の文字がカンマの場合は削除 
            if change_number[2] === ","
                change_number.slice!(2)
            end

            # 単位ごとに分けた配列を作成
            numbers_array = change_number.split(/,/)

            # 配列内で乗算し、足し算で結合する
            english_number = 0
            numbers_array.each do |block_numbers|

                max_index = block_numbers.length.to_i - 1
                index = 0
                number = 1

                loop do
                    block_number_result = block_numbers[index].gsub(/[十|百|千|万|億|兆]/,"十"=>"10","百"=>"100","千"=>"1000","万"=>"10000","億"=>"100000000","兆"=>"1000000000000").to_i

                    # 配列の文字列部分が0になる為除外する
                    unless block_number_result === 0
                        number = number * block_number_result
                    end

                    if index === max_index
                        break
                    end

                    index += 1
                end

                english_number += number

            end

            puts english_number

            return english_number



        ## 数字->漢字
        elsif num_divide === true
        
            # 桁数を取得しエラーを返す
            if number.length.to_i > 18
                puts "error"
                return "error"
            end

            # 各単位で区切るために配列を作成
            numbers_array = number.reverse.tr("123456789", "一二三四五六七八九").split("")

            # 余分な文字列部分を除外
            numbers_array.delete('"')
            numbers_array.delete('[')
            numbers_array.delete(']')

            # 単位を組み合わせて結合する
            c_characters_number = numbers_array[12] === "0" || numbers_array[12] === nil ? "" : numbers_array[12].to_s + "兆"
            c_characters_number += numbers_array[11] === "0" || numbers_array[11] === nil  ? "" : numbers_array[11].to_s + "千"
            c_characters_number += numbers_array[10] === "0"  || numbers_array[10] === nil ? "" : numbers_array[10].to_s + "百"
            c_characters_number += numbers_array[9] === "0" || numbers_array[9] === nil  ? "" : numbers_array[9].to_s + "十"
            
            if numbers_array[8] === "0" && numbers_array[9] != nil
                c_characters_number += "億" 
            elsif numbers_array[8] != "0" && numbers_array[8] != nil
                c_characters_number += numbers_array[8].to_s + "億"
            end

            c_characters_number += numbers_array[7] === "0" || numbers_array[7] === nil  ? "" : numbers_array[7].to_s + "千"
            c_characters_number += numbers_array[6] === "0" || numbers_array[6] === nil  ? "" : numbers_array[6].to_s + "百"
            c_characters_number += numbers_array[5] === "0" || numbers_array[5] === nil  ? "" : numbers_array[5].to_s + "十"
            
            if numbers_array[4] === "0" && numbers_array[5] != nil
                c_characters_number += "万"
            elsif numbers_array[4] != "0" && numbers_array[4] != nil
                c_characters_number += numbers_array[4].to_s + "万"
            else
            end

            c_characters_number += numbers_array[3] === "0" || numbers_array[3] === nil  ? "" : numbers_array[3].to_s + "千"
            c_characters_number += numbers_array[2] === "0" || numbers_array[2] === nil  ? "" : numbers_array[2].to_s + "百"
            c_characters_number += numbers_array[1] === "0" || numbers_array[1] === nil  ? "" : numbers_array[1].to_s + "十"
            c_characters_number += numbers_array[0] === "0" || numbers_array[0] === nil  ? "" : numbers_array[0].to_s

            puts c_characters_number
            return c_characters_number
            
        end

    rescue => e
        p e.message
    end
end

n_change($*.to_s)
