Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbTCIBKO>; Sat, 8 Mar 2003 20:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262330AbTCIBKO>; Sat, 8 Mar 2003 20:10:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47084 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262329AbTCIBKN>;
	Sat, 8 Mar 2003 20:10:13 -0500
Message-Id: <200303090121.h291LDbx003771@eeyore.valparaiso.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: root@chaos.analogic.com
Subject: Re: Make ipconfig.c work as a loadable module. 
In-Reply-To: Your message of "Fri, 07 Mar 2003 11:23:56 CDT."
             <Pine.LNX.3.95.1030307094333.15013A-100000@chaos> 
Date: Sat, 08 Mar 2003 22:21:13 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> said:

[...]

> As the kernel changes there are some things that really need to remain.
> You need to be able to boot from a "floppy" disk.

No...

>                                                   Yes, now-days it's
> probably not a real floppy, but a BIOS module that emulates a floppy.
> A lot of people don't realilize that this is how a CD/ROM is booted!

Red Hat 8.0 boots directly from the ISO filesystem, IIUC. Plus "floppy
booting" mostly means using FreeDOS + syslinux, or even an ext2 floppy with
lilo or grub. The "floppy booting" discussed here is doing:

   dd if=bzImage of=/dev/fd0

and booting that floppy directly. I really don't remember when I did that
last time, it must have been at least 5 years ago.

Embedded systems I've seen do strange shenanigans with custom bootloaders
to get the kernel into RAM, no floppy involved.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
