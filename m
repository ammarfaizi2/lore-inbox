Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264752AbRFXVRq>; Sun, 24 Jun 2001 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbRFXVRg>; Sun, 24 Jun 2001 17:17:36 -0400
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:16098 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S264752AbRFXVRb>; Sun, 24 Jun 2001 17:17:31 -0400
Message-Id: <5.1.0.14.2.20010624141432.00a52f38@mail.abac.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 24 Jun 2001 14:22:04 -0700
To: "John Nilsson" <pzycrow@hotmail.com>
From: Android <android@abac.com>
Subject: Re: Some experience of linux on a Laptop
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I have come to the conclusion that linux is NOT suitable for the general 
>desktop market.

I have to disagree on this. It runs fine on most PC's, as they use standard 
devices.
Just say NO to anything proprietary. This includes Toshiba. Makers of such 
odd machines
should supply their own native drivers if they want to be supported.


>Features I would like in the kernel:
>1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
>trigged before rootmount.

How can you load modules into the kernel before root is mounted?
No harddrive accessible means no modules.


>2: Compile time optimization options in Make menuconfig


>3: Lilo/grub config in make menuconfig

Why?

>4: make bzImage && make modules && make modules install && cp 
>arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig
>
>5: Better support for toshiba computers... well try =)

Talk to Toshiba. See if they are willing to part with "secret" information 
so that you
can create specific drivers for Linux. After that, I bet your next comp. 
won't be from them. :-)


>6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the 
>graphiccard drivers where kernel modules?
Again, Framebuffer cannot be a module as it needs to be in place before the 
kernel even gets to init (the program).
Since the kernel cannot load modules before the drives are mounted, no 
module here.


>7: As I said mount with statistics database of files.
Just how much detail of file usage do you want?
Just open and close? Do you want reads and writes too?


>8: A way to change kernel without rebooting. I have no diskdrive or 
>cddrive in my laptop so I often do drastic things when I install a new 
>distribution.
>
In order to change the kernel, all running processes must be terminated.
How can you install a new kernel without any process to make the changeover?


>I'm not on the list so please CC me any responses
>
>John Nilsson

-- Replies by Ted


