Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292353AbSB0TGV>; Wed, 27 Feb 2002 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292891AbSB0TF4>; Wed, 27 Feb 2002 14:05:56 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:8161
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S292761AbSB0TFl>; Wed, 27 Feb 2002 14:05:41 -0500
Message-ID: <3C7D2E2A.8000905@st-peter.stw.uni-erlangen.de>
Date: Wed, 27 Feb 2002 20:06:18 +0100
From: svetljo <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compiling Linux 2.5.5-dj2 + console_8.diff
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *16g9OP-0004jK-00*5xhkppHjZEA* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUILD_BASENAME=dummycon  -c -o dummycon.o dummycon.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5-xfs-dj2/include  -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   
-DKBUILD_BASENAME=vgacon  -c -o vgacon.o vgacon.c
vgacon.c: In function `vgacon_do_font_op':
vgacon.c:816: structure has no member named `vc_sw'
make[3]: *** [vgacon.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.5-xfs-dj2/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.5-xfs-dj2/drivers/video

