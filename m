Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131990AbRDPTnP>; Mon, 16 Apr 2001 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRDPTnG>; Mon, 16 Apr 2001 15:43:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16399 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131990AbRDPTms>; Mon, 16 Apr 2001 15:42:48 -0400
Date: Mon, 16 Apr 2001 15:01:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: buz.c compile error
Message-ID: <Pine.LNX.4.21.0104161500450.3211-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.4-pre3.

gcc -D__KERNEL__ -I/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/include
-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-pipe -mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS
-include
/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/include/linux/modversions.h
-c -o buz.o buz.c
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
make[3]: Leaving directory
`/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory
`/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory
`/home/marcelo/rpm/BUILD/kernel-2.4.3/linux/drivers'
make: *** [_mod_drivers] Error 2


