Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRKSKAo>; Mon, 19 Nov 2001 05:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277112AbRKSKAe>; Mon, 19 Nov 2001 05:00:34 -0500
Received: from Expansa.sns.it ([192.167.206.189]:35592 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S277152AbRKSKA0>;
	Mon, 19 Nov 2001 05:00:26 -0500
Date: Mon, 19 Nov 2001 11:00:27 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: Fatal error compiling on 2.4.15-pre6aa1.
Message-ID: <Pine.LNX.4.33.0111191058190.28483-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI, compiling this kernel for ultrasparc64, i got also this error,

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4.15-pre6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs    -c -o ioctl32.o ioctl32.c
ioctl32.c: In function `do_lvm_ioctl':
ioctl32.c:2636: warning: assignment makes pointer from integer without a
cast
ioctl32.c:2670: structure has no member named `inode'
ioctl32.c:2711: warning: assignment from incompatible pointer type
ioctl32.c:2712: structure has no member named `inode'
ioctl32.c:2719: structure has no member named `inode'
ioctl32.c:2732: structure has no member named `inode'
ioctl32.c:2611: warning: `v' might be used uninitialized in this function
make[1]: *** [ioctl32.o] Error 1

LVM support is statically enable in my configuration


Luigi

