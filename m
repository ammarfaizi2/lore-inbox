Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbTDCIzD>; Thu, 3 Apr 2003 03:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbTDCIzD>; Thu, 3 Apr 2003 03:55:03 -0500
Received: from math.ut.ee ([193.40.5.125]:2199 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S263324AbTDCIzD>;
	Thu, 3 Apr 2003 03:55:03 -0500
Date: Thu, 3 Apr 2003 12:06:28 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: i810_audio compile error in 2.4.21-pre7 BK
Message-ID: <Pine.GSO.4.44.0304031205060.3191-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

gcc -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/mroos/compile/linux-2.4/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_audio  -c -o i810_audio.o i810_audio.c
i810_audio.c: In function `i810_ac97_init':
i810_audio.c:2930: structure has no member named `modem'
i810_audio.c: In function `i810_probe':
i810_audio.c:3261: warning: label `out_chan' defined but not used
make[2]: *** [i810_audio.o] Error 1

-- 
Meelis Roos (mroos@linux.ee)

