Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSAITF3>; Wed, 9 Jan 2002 14:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSAITFU>; Wed, 9 Jan 2002 14:05:20 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:31754 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S288967AbSAITFB>;
	Wed, 9 Jan 2002 14:05:01 -0500
Date: Wed, 9 Jan 2002 20:04:54 +0100 (CET)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: build errors 2.4.18-pre2
Message-ID: <Pine.LNX.4.33.0201092004200.27466-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/home/pau/LnxZip/RPM/BUILD/kernel-2.4.18pre2/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/pau/LnxZip/RPM/BUILD/kernel-2.4.18pre2/include/linux/modversions.h   
-c -o radeonfb.o radeonfb.c
radeonfb.c: In function `radeon_save_state':
radeonfb.c:2283: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this 
function)
radeonfb.c:2283: (Each undeclared identifier is reported only once
radeonfb.c:2283: for each function it appears in.)
radeonfb.c: In function `radeon_load_video_mode':
radeonfb.c:2560: `TMDS_RAN_PAT_RST' undeclared (first use in this 
function)
radeonfb.c:2561: `ICHCSEL' undeclared (first use in this function)
radeonfb.c:2561: `TMDS_PLLRST' undeclared (first use in this function)
radeonfb.c: In function `radeon_write_mode':
radeonfb.c:2650: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this 
function)
radeonfb.c:2655: `LVDS_STATE_MASK' undeclared (first use in this function)
radeonfb.c: At top level:
radeonfb.c:2957: warning: `fbcon_radeon8' defined but not used
make[3]: *** [radeonfb.o] Error 1
make[3]: Leaving directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.4.18pre2/drivers/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory 
`/home/pau/LnxZip/RPM/BUILD/kernel-2.4.18pre2/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/home/pau/LnxZip/RPM/BUILD/kernel-2.4.18pre2'
error: Bad exit status from /home/pau/LnxZip/tmp/rpm-tmp.6614 (%build)


-- 

Pau

