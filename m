Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264058AbSIVNXJ>; Sun, 22 Sep 2002 09:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbSIVNXJ>; Sun, 22 Sep 2002 09:23:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55533 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264058AbSIVNXI>; Sun, 22 Sep 2002 09:23:08 -0400
Date: Sun, 22 Sep 2002 15:28:13 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: pdc4030.c doesn't compile in 2.5.38
Message-ID: <Pine.NEB.4.44.0209221522290.18211-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

<--  snip  -->

...
  gcc -Wp,-MD,./.pdc4030.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.38-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -I/home/bunk/linux/kernel-2.5/linux-2.5.38-full/arch/i386/mach-generic
-nostdinc -iwithprefix include  -I../  -DKBUILD_BASENAME=pdc4030   -c -o
pdc4030.o pdc4030.c
pdc4030.c: In function `promise_read_intr':
pdc4030.c:465: too few arguments to function
pdc4030.c: In function `promise_complete_pollfunc':
pdc4030.c:542: too few arguments to function
pdc4030.c: In function `promise_multwrite':
pdc4030.c:587: structure has no member named `bh'
pdc4030.c:593: structure has no member named `bh'
pdc4030.c:594: dereferencing pointer to incomplete type
pdc4030.c:596: dereferencing pointer to incomplete type
pdc4030.c: In function `do_pdc4030_io':
pdc4030.c:738: switch quantity not an integer
pdc4030.c:793: warning: int format, pointer arg (arg 3)
pdc4030.c:794: too few arguments to function
pdc4030.c:741: warning: unreachable code at beginning of switch statement
make[3]: *** [pdc4030.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.38-full/drivers/ide/legacy'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




