Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDECAt>; Wed, 4 Apr 2001 22:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDECAj>; Wed, 4 Apr 2001 22:00:39 -0400
Received: from moshier.ne.mediaone.net ([24.147.16.206]:62793 "EHLO
	moshier.ne.mediaone.net") by vger.kernel.org with ESMTP
	id <S132540AbRDECA3>; Wed, 4 Apr 2001 22:00:29 -0400
Date: Wed, 4 Apr 2001 21:59:43 -0400 (EDT)
From: Stephen L Moshier <moshier@mediaone.net>
Reply-To: moshier@moshier.ne.mediaone.net
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 video module build failure
Message-ID: <Pine.LNX.4.20.0104042155540.17163-100000@moshier.ne.mediaone.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for linux-2.4.3 configured with multimedia/video selected as a module.

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-O2 -fomit-f
rame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i586
 -DMODULE   -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this
function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/media/video'

