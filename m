Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRKNM7n>; Wed, 14 Nov 2001 07:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280577AbRKNM7d>; Wed, 14 Nov 2001 07:59:33 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:63498 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S280570AbRKNM7Q>; Wed, 14 Nov 2001 07:59:16 -0500
Message-Id: <200111141259.fAECx6KZ012150@pincoya.inf.utfsm.cl>
To: Thorsten Kukuk <kukuk@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan 
In-Reply-To: Message from Thorsten Kukuk <kukuk@suse.de> 
   of "Tue, 13 Nov 2001 16:21:02 BST." <20011113162102.A2305@suse.de> 
Date: Wed, 14 Nov 2001 09:59:06 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Kukuk <kukuk@suse.de> said:
> On Tue, Nov 13, Horst von Brand wrote:
> 
> > On CVS as of today for sparc64 I get:
> > 
> > sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-pr
> oto
> > types -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-commo
> n -
> > m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5
>  -f
> > call-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o ioctl32.o ioctl
> 32.
> > c
> > ioctl32.c: In function `do_lvm_ioctl':
> > ioctl32.c:2636: warning: assignment makes pointer from integer without a cast
> > ioctl32.c:2670: structure has no member named `inode'
> > ioctl32.c:2711: warning: assignment from incompatible pointer type
> > ioctl32.c:2712: structure has no member named `inode'
> > ioctl32.c:2719: structure has no member named `inode'
> > ioctl32.c:2732: structure has no member named `inode'
> > ioctl32.c:2611: warning: `v' might be used uninitialized in this function
> > make[1]: *** [ioctl32.o] Error 1
> > make[1]: Leaving directory `/usr/src/linux-2.4/arch/sparc64/kernel'
> > make: *** [_dir_arch/sparc64/kernel] Error 2
> 
> Please try the both attached patches. I'm using them with 
> 2.4.15pre1aa1 (which has the same lvm version as now 2.2.15pre4).

Whatever patches went into CVS since yesterday fixed that one (in a
different way).

Thanks!
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
