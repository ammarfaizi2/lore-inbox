Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315428AbSEHWJi>; Wed, 8 May 2002 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315436AbSEHWJh>; Wed, 8 May 2002 18:09:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:31474 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315428AbSEHWJg>; Wed, 8 May 2002 18:09:36 -0400
Date: Thu, 9 May 2002 00:04:40 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac1
In-Reply-To: <200205080045.g480j1404809@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0205090002020.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

with CONFIG_VIDEO_MARGI enabled compilation fails with the following
error:

<--  snip  -->

...
make[4]: Entering directory
`/home/bunk/linux/kernel-2.4/linux-full/drivers/media/video'
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=videodev  -c
-o videodev.o videodev.c
make[4]: *** No rule to make target `margi/margi_cs.o', needed by
`video.o'.  Stop.
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-full/drivers/media/video'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

