Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291399AbSB0ByC>; Tue, 26 Feb 2002 20:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSB0Bxw>; Tue, 26 Feb 2002 20:53:52 -0500
Received: from [203.94.130.164] ([203.94.130.164]:33299 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S291372AbSB0Bxc>;
	Tue, 26 Feb 2002 20:53:32 -0500
Date: Wed, 27 Feb 2002 13:23:08 +1100 (EST)
From: Brett <brett@bad-sports.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-dj2 opl3sa2 as module compile failure
Message-ID: <Pine.LNX.4.44.0202271321230.29386-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

something fun for you all...

thanks,

	/ Brett


gcc -D__KERNEL__ -I/usr/src/linux-2.5.5-dj2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i586 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.5.5-dj2/include/linux/modversions.h  
-DKBUILD_BASENAME=opl3sa2  -c -o opl3sa2.o opl3sa2.c
opl3sa2.c: In function `opl3sa2_pm_callback':
opl3sa2.c:979: warning: cast from pointer to integer of different size
opl3sa2.c: In function `cleanup_opl3sa2':
opl3sa2.c:1143: `opl3sa2_data' undeclared (first use in this function)
opl3sa2.c:1143: (Each undeclared identifier is reported only once
opl3sa2.c:1143: for each function it appears in.)
opl3sa2.c:1146: `cfg_mpu' undeclared (first use in this function)
make[2]: *** [opl3sa2.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5-dj2/sound/oss'
make[1]: *** [_modsubdir_oss] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5-dj2/sound'
make: *** [_mod_sound] Error 2


