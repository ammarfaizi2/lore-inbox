Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131473AbRCWWJQ>; Fri, 23 Mar 2001 17:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRCWWJG>; Fri, 23 Mar 2001 17:09:06 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:25606 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131474AbRCWWIr>; Fri, 23 Mar 2001 17:08:47 -0500
Message-Id: <200103232206.f2NM6axY003350@pincoya.inf.utfsm.cl>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac23 
In-Reply-To: Message from Adrian Bunk <bunk@fs.tum.de> 
   of "Fri, 23 Mar 2001 15:06:14 +0100." <Pine.NEB.4.33.0103231456500.26499-200000@pluto.fachschaften.tu-muenchen.de> 
Date: Fri, 23 Mar 2001 18:06:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> said:
> 2.4.2-ac23
> ...
> o       Fix i386 #ifdef bug with notsc disable          (Anton Blanchard)
> ...
> 
> 
> This change has broken the compile for me (my .config is attached):
> 
> gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=k6    -c -o setup.o setup.c
> setup.c: In function `identify_cpu':
> setup.c:2280: `tsc_disable' undeclared (first use in this function)
> setup.c:2280: (Each undeclared identifier is reported only once
> setup.c:2280: for each function it appears in.)
> setup.c: In function `get_cpuinfo':
> setup.c:2378: warning: unused variable `x86_udelay_tsc'
> make[1]: *** [setup.o] Error 1
> make[1]: Leaving directory `/home/bunk/linux/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2

Same here. i686 in a Toshiba Satellite Pro laptop.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
