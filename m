Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSJaMbw>; Thu, 31 Oct 2002 07:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265220AbSJaMbw>; Thu, 31 Oct 2002 07:31:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49115 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264822AbSJaMbv>; Thu, 31 Oct 2002 07:31:51 -0500
Date: Thu, 31 Oct 2002 13:38:13 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: bcollins@debian.org, <linux1394-devel@lists.sourceforge.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ieee1394/sbp2.c doesn't compile in 2.5.45
Message-ID: <Pine.NEB.4.44.0210311336360.10655-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

<--  snip  -->

  gcc -Wp,-MD,drivers/ieee1394/.sbp2.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=sbp2   -c -o drivers/ieee1394/sbp2.o
drivers/ieee1394/sbp2.c
In file included from drivers/ieee1394/sbp2.c:349:
drivers/ieee1394/sbp2.h:555: parse error before `*'
drivers/ieee1394/sbp2.h:555: warning: function declaration isn't a prototype
drivers/ieee1394/sbp2.c: In function `sbp2scsi_biosparam':
drivers/ieee1394/sbp2.c:3155: `capacity' undeclared (first use in this function)
drivers/ieee1394/sbp2.c:3155: (Each undeclared identifier is reported only once
drivers/ieee1394/sbp2.c:3155: for each function it appears in.)
drivers/ieee1394/sbp2.c:3149: warning: `cylinders' might be used uninitialized in this function
make[2]: *** [drivers/ieee1394/sbp2.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



