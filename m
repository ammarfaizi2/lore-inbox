Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSIAA0Y>; Sat, 31 Aug 2002 20:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIAA0Y>; Sat, 31 Aug 2002 20:26:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5627 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318060AbSIAA0Y>; Sat, 31 Aug 2002 20:26:24 -0400
Date: Sun, 1 Sep 2002 02:30:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: R.E.Wolff@BitWizard.nl
cc: linux-kernel@vger.kernel.org
Subject: drivers/atm/firestream.c doesn't compile in 2.5.33
Message-ID: <Pine.NEB.4.44.0209010227250.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<--  snip  -->

...
  gcc -Wp,-MD,./.firestream.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.33-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=firestream
-c -o firestream.o firestream.c
firestream.c: In function `fs_open':
firestream.c:870: called object is not a function
firestream.c:870: parse error before string constant
firestream.c:1097: called object is not a function
firestream.c:1097: parse error before string constant
firestream.c: In function `fs_close':
firestream.c:1109: called object is not a function
firestream.c:1109: parse error before string constant
firestream.c:1159: called object is not a function
firestream.c:1159: parse error before string constant
...
make[2]: *** [firestream.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.33-full/drivers/atm'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

