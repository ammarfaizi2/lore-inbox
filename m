Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSIPKDk>; Mon, 16 Sep 2002 06:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSIPKDk>; Mon, 16 Sep 2002 06:03:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13053 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261289AbSIPKDj>; Mon, 16 Sep 2002 06:03:39 -0400
Date: Mon, 16 Sep 2002 12:08:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: dwmw2@infradead.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.35
In-Reply-To: <Pine.LNX.4.33.0209151926330.10806-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0209161206590.14886-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:

Since 2.5.34 the compilation of JFFS2 fails with a compile error similar
to the one in JFFS:

<--  snip  -->

...
  gcc -Wp,-MD,./.background.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.35/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=background
-c -o background.o background.c
background.c: In function `jffs2_garbage_collect_thread':
background.c:118: warning: passing arg 1 of `dequeue_signal' from
incompatible pointer type
background.c:118: warning: passing arg 2 of `dequeue_signal' from
incompatible pointer type
background.c:118: too few arguments to function `dequeue_signal'
make[2]: *** [background.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.35/fs/jffs2'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

