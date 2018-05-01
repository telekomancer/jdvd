video=$1
instagram () {
	get=$(wget $video -q -O - 2>/dev/null | grep -Po 'www.instagram.com[^"]+' | sed 's#embed/##g' | grep -v jaidefinichon )
	insta=$(echo "https://"$get)
	}

tumblr () {
	get2=$(wget $video -q -O - 2>/dev/null | grep tumblr | grep video | grep -o -P '(?<=i_Frame).*(?=style)' | sed -e 's:"><::g' -e 's:iframe src=::g' -e 's/style.*$//g' | sed "s/'//g" )
	get3=$(wget $get2 -q -O - 2>/dev/null | grep video_file | grep -o -P '(?<=src).*(?=type)' | sed -e 's:="::g' -e 's/"//g')
	}

tumblr

if [[ $get2 == *"tumblr"* ]]
	then
		echo "Downloading video from tumblr"
		var=$(echo $get3 | awk -F"/" '{print $NF".mp4"}')
		wget $get3 -O $var --progress=bar:force:noscroll
		exit
	fi

instagram

if [[ $get == *"instagram"* ]]
	then
		echo "Downloading video from instagram"
		vid=$(wget $insta -q -O - 2>/dev/null| grep -Po 'instagram.[^"]+' | grep mp4 | uniq)
		conv=$(echo "https://"$vid)
		wget $conv --progress=bar:force:noscroll
		exit
	else
		echo "Not recognized, am leaving, bye!"
		exit
	fi
