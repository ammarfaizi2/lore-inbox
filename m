Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSHOUpi>; Thu, 15 Aug 2002 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSHOUpi>; Thu, 15 Aug 2002 16:45:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34812 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317458AbSHOUph>; Thu, 15 Aug 2002 16:45:37 -0400
Date: Thu, 15 Aug 2002 22:49:26 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, <kai.germaschewski@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <200208151918.g7FJI6J04061@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208152235040.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre2-ac2
>...
> o	Tweak isdn to try and fix gcc 2.95 compile 	(Kai Germaschewski)
>...

Compilation of 2.4.20-pre2-ac3 fails:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.19-full/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-DHISAX_MAX_CARDS=8 -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=st5481_init
-c -o st5481_init.o st5481_init.c
st5481_init.c: In function `disconnect_st5481':
st5481_init.c:137: parse error before `)'
make[4]: *** [st5481_init.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full/drivers/isdn/hisax'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



