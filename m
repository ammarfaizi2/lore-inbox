Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289559AbSAJRTi>; Thu, 10 Jan 2002 12:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289560AbSAJRT1>; Thu, 10 Jan 2002 12:19:27 -0500
Received: from web14902.mail.yahoo.com ([216.136.225.54]:28279 "HELO
	web14902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289559AbSAJRTS>; Thu, 10 Jan 2002 12:19:18 -0500
Message-ID: <20020110171525.55894.qmail@web14902.mail.yahoo.com>
Date: Thu, 10 Jan 2002 12:15:25 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: About Loop Device
To: linux-kernel@vger.kernel.org
Cc: root@chaos.analogic.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, now I can use the "mount -o loop /dev/fd0 /mnt" to
mount the loop device after I use mke2fs format the
/dev/fd0. But how can I test it? What are the
/dev/loop0,/dev/loop1.....,/dev/loop7 used for? Are
there any detailed informations about how to use the
loop device? I've read some souce code about the
loop.c file. But not fully understand. Can anyone give
me a hand on this. Thanks in advance.

Michael


On Wed, 9 Jan 2002, Michael Zhu wrote:

> Thanks for the reply. But when I try to use the
> command "mount -o loop /dev/fd0 /floppy", the mount
> returns an error saying "mount: you must specify the
> filesystem type". What is wrong? Thanks.
> 
> Michael
>

man mount

mount -o loop -t ext2  /dev/fd0 /mnt   # Usual linux
mount -o loop -t msdos /dev/fd0 /mnt   # DOS
file-system
mount -o loop -t vfat  /dev/fd0 /mnt   # Win/NT, etc.
                    |         |    |__________
mount-point
                    |         |_______________ device
                    |_________________________
File-system type




Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine
(797.90 BogoMips).

    I was going to compile a list of innovations that
could be
    attributed to Microsoft. Once I realized that
Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't
any.


______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
