Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267833AbTAHPme>; Wed, 8 Jan 2003 10:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267838AbTAHPme>; Wed, 8 Jan 2003 10:42:34 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18446 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S267833AbTAHPme>; Wed, 8 Jan 2003 10:42:34 -0500
Date: Wed, 8 Jan 2003 10:51:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.54 aha152c doesn't compile
Message-ID: <Pine.LNX.4.44.0301081050030.18739-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/scsi
  gcc -Wp,-MD,drivers/scsi/.aha1542.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=aha1542 -DKBUILD_MODNAME=aha1542   -c -o drivers/scsi/aha1542.o drivers/scsi/aha1542.c
drivers/scsi/aha1542.c: In function `aha1542_detect':
drivers/scsi/aha1542.c:1152: warning: implicit declaration of function `isapnp_find_dev'
drivers/scsi/aha1542.c:1153: warning: assignment makes pointer from integer without a cast
drivers/scsi/aha1542.c:1160: structure has no member named `prepare'
drivers/scsi/aha1542.c:1168: structure has no member named `activate'
make[2]: *** [drivers/scsi/aha1542.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

