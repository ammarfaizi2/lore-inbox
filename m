Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281631AbRKMOKv>; Tue, 13 Nov 2001 09:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281629AbRKMOKc>; Tue, 13 Nov 2001 09:10:32 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:21772 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S281627AbRKMOKU>; Tue, 13 Nov 2001 09:10:20 -0500
Message-Id: <200111131410.fADEA9L8023291@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Mon, 12 Nov 2001 11:01:56 -0800." <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com> 
Date: Tue, 13 Nov 2001 11:10:09 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On CVS as of today for sparc64 I get:

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-proto
types -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -
m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -f
call-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o ioctl32.o ioctl32.
c
ioctl32.c: In function `do_lvm_ioctl':
ioctl32.c:2636: warning: assignment makes pointer from integer without a cast
ioctl32.c:2670: structure has no member named `inode'
ioctl32.c:2711: warning: assignment from incompatible pointer type
ioctl32.c:2712: structure has no member named `inode'
ioctl32.c:2719: structure has no member named `inode'
ioctl32.c:2732: structure has no member named `inode'
ioctl32.c:2611: warning: `v' might be used uninitialized in this function
make[1]: *** [ioctl32.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4/arch/sparc64/kernel'
make: *** [_dir_arch/sparc64/kernel] Error 2
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
