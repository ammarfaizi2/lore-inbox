Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264848AbSKENUz>; Tue, 5 Nov 2002 08:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSKENUz>; Tue, 5 Nov 2002 08:20:55 -0500
Received: from green.pwm-1.clinic.net ([216.204.105.145]:28167 "EHLO
	green.pwm-1.clinic.net") by vger.kernel.org with ESMTP
	id <S264848AbSKENUy>; Tue, 5 Nov 2002 08:20:54 -0500
Date: Tue, 5 Nov 2002 08:24:16 -0500 (EST)
From: David G Hamblen <dave@AFRInc.com>
Reply-To: dave@AFRinc.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 won't compile with pcmcia_aha152x
In-Reply-To: <4.3.2.7.2.20021105141812.00c5ccd0@192.168.6.2>
Message-ID: <Pine.LNX.4.44.0211050813050.12822-100000@puppy.afrinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last time I tried (2.5.29), this stuff worked. The next time I tried
(2.5.39) it failed.  Here's the error with 2.5.46:

  gcc -Wp,-MD,drivers/scsi/pcmcia/.aha152x_stub.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE -include include/linux/modversions.h
-DKBUILD_BASENAME=aha152x_stub   -c -o drivers/scsi/pcmcia/aha152x_stub.o
drivers/scsi/pcmcia/aha152x_stub.c
make[4]: *** No rule to make target `drivers/scsi/pcmcia/aha152x.s',
needed by `drivers/scsi/pcmcia/aha152x.o'.  Stop.




			Dave


