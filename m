Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbRFXVMZ>; Sun, 24 Jun 2001 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbRFXVMP>; Sun, 24 Jun 2001 17:12:15 -0400
Received: from CM-46-30.chello.cl ([24.152.46.30]:63110 "EHLO
	CM-46-30.chello.cl") by vger.kernel.org with ESMTP
	id <S264745AbRFXVMD> convert rfc822-to-8bit; Sun, 24 Jun 2001 17:12:03 -0400
Date: Sun, 24 Jun 2001 17:08:54 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
To: John Nilsson <pzycrow@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Message-ID: <Pine.LNX.4.21.0106241700140.1390-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, let's see:

On Sun, 24 Jun 2001, John Nilsson wrote:

> Well I thought that it was time for me to give some feedback to the linux 
> community. So I will tell you guys a little of my experience with linux so 
> far.
> 
> I have a Toshiba Portégé 3010CT laptop. That is:
> 266MHz Pentium-MMX
> 4GB HD with 512kb cache (which linux reduces to 0kb)
> 32 Mb EDO RAM
> 
> After have tried
> Slackware
> Gentoo
> Linux From Scratch
> Debian
> Mandrake
> and soon ROCK linux
> 
> I have come to the conclusion that linux is NOT suitable for the general 
> desktop market, I have configured a number of linux routers/fierwalls and am 
> really pleased with the scalability, but the harware compatibility is to 
> damn low for a general user base. I know this isn't really a Linux issue 
> rather a distribution issue, but in the end it's you guys that make the 
> drivers. So a little plea is that you let the optimization phase cooldown a 
> little and concern your self a little more with compatibility, and ease of 
> installation, (tidy up the kernel build system).
> 
> On my particular computer the chipset (toshiba specific) is not supported 
> wich makes the harddrive unable to run in UDMA and/or use it's cache. 
> Somehow this make X totaly unusable. With a little luck if it doesn't hang 
> it takes several minutes to launch a simple program.
> This could be X specific, but I doub't it.
> 
> So when you speak of being able to run on 386:es I still have problem 
> starting X on 266MHz with 32Mb mem. This should not be =)
> 
> And regarding my slow HD, could anyone implment an option to mount a 
> filesystem while keeping statistics on fileusage so that one could optimize 
> physical-file-placement?
> 
> 
> Features I would like in the kernel:
> 1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
> trigged before rootmount.

Kernel module loader?, done.

> 
> 2: Compile time optimization options in Make menuconfig

I dunno what do you mean exactly with that.

> 3: Lilo/grub config in make menuconfig

Not the only way to start linux. Make install does with lilo.

> 4: make bzImage && make modules && make modules install && cp 
> arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig

make install?, done.

> 
> 5: Better support for toshiba computers... well try =)

Don't have one.

> 
> 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the 
> graphiccard drivers where kernel modules?

Have you heard of XFree86 project?.

> 
> 7: As I said mount with statistics database of files.

Logging?, it should be enough of that if you take a look at /var/log.

> 
> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive 
> in my laptop so I often do drastic things when I install a new distribution.
 
Don't you have enough features?. When you install a new aplication you
don't have to reboot three times the machine ;-)
Imposible to do that for now. (Take a look at HURD).

> 
> I'm not on the list so please CC me any responses
> 
> /John Nilsson
> _________________________________________________________________________
> Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

 ---
 Fabian Arias Mu~oz                    |               Debian GNU/Linux Sid
 Facultad de Cs. Economicas y          |      	Kernel 2.4.5ac17 - ReiserFS
 Administrativas.                      |                   "aka" dewback en
 Universidad de Concepcion   -  Chile  |               #linuxhelp IRC.CHILE

