Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbSJARef>; Tue, 1 Oct 2002 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262185AbSJARdq>; Tue, 1 Oct 2002 13:33:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23021 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262503AbSJARcV>; Tue, 1 Oct 2002 13:32:21 -0400
Date: Tue, 1 Oct 2002 19:37:42 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/atm/idt77252.c doesn't compile in 2.5.40
Message-ID: <Pine.NEB.4.44.0210011936280.10143-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

<--  snip  -->

  gcc -Wp,-MD,./.idt77252.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=idt77252   -c -o
idt77252.o idt77252.c
idt77252.c: In function `alloc_scq':
idt77252.c:669: warning: unsigned int format, different type arg (arg 5)
idt77252.c: In function `idt77252_interrupt':
idt77252.c:2899: warning: implicit declaration of function `queue_task'
idt77252.c:2899: `tq_immediate' undeclared (first use in this function)
idt77252.c:2899: (Each undeclared identifier is reported only once
idt77252.c:2899: for each function it appears in.)
idt77252.c:2900: warning: implicit declaration of function `mark_bh'
idt77252.c:2900: `IMMEDIATE_BH' undeclared (first use in this function)
make[2]: *** [idt77252.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/drivers/atm'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


