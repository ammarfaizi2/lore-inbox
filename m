Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287692AbRLaX6j>; Mon, 31 Dec 2001 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287694AbRLaX6U>; Mon, 31 Dec 2001 18:58:20 -0500
Received: from fe8.southeast.rr.com ([24.93.67.55]:26642 "EHLO
	mail8.carolina.rr.com") by vger.kernel.org with ESMTP
	id <S287692AbRLaX6J>; Mon, 31 Dec 2001 18:58:09 -0500
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Mon, 31 Dec 2001 18:57:58 -0500
To: linux-kernel@vger.kernel.org
Subject: radeonfb.o compile error ...
Message-ID: <20011231235758.GA9829@clt88-175-140.carolina.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/swoop/working/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4   -DKBUILD_BASENAME=radeonfb  -c -o
drivers/video/radeonfb.o drivers/video/radeonfb.c
drivers/video/radeonfb.c: In function `radeon_save_state':
drivers/video/radeonfb.c:2283: `TMDS_TRANSMITTER_CNTL' undeclared (first
use in this function)
drivers/video/radeonfb.c:2283: (Each undeclared identifier is reported
only once
drivers/video/radeonfb.c:2283: for each function it appears in.)
drivers/video/radeonfb.c: In function `radeon_load_video_mode':
drivers/video/radeonfb.c:2560: `TMDS_RAN_PAT_RST' undeclared (first use
in this function)
drivers/video/radeonfb.c:2561: `ICHCSEL' undeclared (first use in this
function)
drivers/video/radeonfb.c:2561: `TMDS_PLLRST' undeclared (first use in
this function)
drivers/video/radeonfb.c: In function `radeon_write_mode':
drivers/video/radeonfb.c:2650: `TMDS_TRANSMITTER_CNTL' undeclared (first
use in this function)
drivers/video/radeonfb.c:2655: `LVDS_STATE_MASK' undeclared (first use
in this function)
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2888: warning: `fbcon_radeon_bmove' defined but
not used
drivers/video/radeonfb.c:2928: warning: `fbcon_radeon_clear' defined but
not used
make: *** [drivers/video/radeonfb.o] Error 1

-- 
Zilvinas Valinskas
