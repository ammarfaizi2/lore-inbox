Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264561AbRFXUwc>; Sun, 24 Jun 2001 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRFXUwW>; Sun, 24 Jun 2001 16:52:22 -0400
Received: from f175.law14.hotmail.com ([64.4.21.175]:16147 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264561AbRFXUwC>;
	Sun, 24 Jun 2001 16:52:02 -0400
X-Originating-IP: [194.236.106.153]
From: "John Nilsson" <pzycrow@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Some experience of linux on a Laptop
Date: Sun, 24 Jun 2001 22:51:56 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
X-OriginalArrivalTime: 24 Jun 2001 20:51:56.0627 (UTC) FILETIME=[817DEA30:01C0FCEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I thought that it was time for me to give some feedback to the linux 
community. So I will tell you guys a little of my experience with linux so 
far.

I have a Toshiba Portégé 3010CT laptop. That is:
266MHz Pentium-MMX
4GB HD with 512kb cache (which linux reduces to 0kb)
32 Mb EDO RAM

After have tried
Slackware
Gentoo
Linux From Scratch
Debian
Mandrake
and soon ROCK linux

I have come to the conclusion that linux is NOT suitable for the general 
desktop market, I have configured a number of linux routers/fierwalls and am 
really pleased with the scalability, but the harware compatibility is to 
damn low for a general user base. I know this isn't really a Linux issue 
rather a distribution issue, but in the end it's you guys that make the 
drivers. So a little plea is that you let the optimization phase cooldown a 
little and concern your self a little more with compatibility, and ease of 
installation, (tidy up the kernel build system).

On my particular computer the chipset (toshiba specific) is not supported 
wich makes the harddrive unable to run in UDMA and/or use it's cache. 
Somehow this make X totaly unusable. With a little luck if it doesn't hang 
it takes several minutes to launch a simple program.
This could be X specific, but I doub't it.

So when you speak of being able to run on 386:es I still have problem 
starting X on 266MHz with 32Mb mem. This should not be =)

And regarding my slow HD, could anyone implment an option to mount a 
filesystem while keeping statistics on fileusage so that one could optimize 
physical-file-placement?


Features I would like in the kernel:
1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
trigged before rootmount.

2: Compile time optimization options in Make menuconfig
3: Lilo/grub config in make menuconfig
4: make bzImage && make modules && make modules install && cp 
arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig

5: Better support for toshiba computers... well try =)

6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the 
graphiccard drivers where kernel modules?

7: As I said mount with statistics database of files.

8: A way to change kernel without rebooting. I have no diskdrive or cddrive 
in my laptop so I often do drastic things when I install a new distribution.


I'm not on the list so please CC me any responses

/John Nilsson
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

