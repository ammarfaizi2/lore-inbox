Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbSLEEih>; Wed, 4 Dec 2002 23:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSLEEih>; Wed, 4 Dec 2002 23:38:37 -0500
Received: from bgp996345bgs.nanarb01.mi.comcast.net ([68.40.49.89]:44703 "EHLO
	syKr0n.mine.nu") by vger.kernel.org with ESMTP id <S267212AbSLEEig>;
	Wed, 4 Dec 2002 23:38:36 -0500
Subject: [COMPILE ERROR] BK Tree rev 1.910 ide-scsi.c compile fails
From: Mohamed El Ayouty <melayout@umich.edu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Dec 2002 23:45:52 -0500
Message-Id: <1039063552.2113.37.camel@syKr0n.mine.nu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-2.5 Bitkeeper rev 1.910 

Compile Error on Scsi

gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
-fomit-frame-pointer -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o
drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
drivers/scsi/ide-scsi.c: In function `should_transform':
drivers/scsi/ide-scsi.c:767: structure has no member named `tag'
make[2]: *** [drivers/scsi/ide-scsi.o] Error 1
rm drivers/scsi/scsi_sysfs.c
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

Mohamed El Ayouty
