Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289646AbSAWC1Y>; Tue, 22 Jan 2002 21:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289645AbSAWC1N>; Tue, 22 Jan 2002 21:27:13 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:5904 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S289646AbSAWC1I>; Tue, 22 Jan 2002 21:27:08 -0500
Subject: video1394.c:868:  In function `do_iso_mmap': too few arguments to
	function `remap_page_range'
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 22 Jan 2002 18:26:07 -0800
Message-Id: <1011752768.24310.57.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE   -c -o video1394.o video1394.c
video1394.c: In function `do_iso_mmap':
video1394.c:868: warning: passing arg 1 of `remap_page_range' makes pointer from integer without a cast
video1394.c:868: incompatible type for argument 4 of `remap_page_range'
video1394.c:868: too few arguments to function `remap_page_range'
make[2]: *** [video1394.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'

CONFIG_IEEE1394=m
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_VERBOSEDEBUG=y


