Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbTDQKxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTDQKxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 06:53:38 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:2283 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261306AbTDQKxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 06:53:36 -0400
Date: Thu, 17 Apr 2003 13:17:14 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems booting 2.5 kernel, rh9
Message-ID: <20030417111714.GA16335@wind.cocodriloo.com>
References: <000501c3048d$a3e41700$0200a8c0@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000501c3048d$a3e41700$0200a8c0@satellite>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 11:01:27PM -0400, Dave Mehler wrote:
> Hello,
>     Compiled/installed a 2.5 kernel on my rh9 box, everything went alright.
> When i try to boot it this is what i get, any ideas? I don't see an error,
> very weird. I've installed the new modutils rpm and the procpsutils as well.
> Thanks.
> Dave.
> 
> 
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> Press any key to continue.
> 
>     GRUB  version 0.93  (639K lower / 261040K upper memory)
> 
>  +-------------------------------------------------------------------------+
>       Use the ^ and v keys to select which entry is highlighted.
>       Press enter to boot the selected OS, 'e' to edit the
>       commands before booting, 'a' to modify the kernel arguments
>   Booting 'Red Hat Linux (2.5.67)'
> 
> root (hd0,0)
>  Filesystem type is ext2fs, partition type 0x83
> kernel /boot/vmlinuz-2.5.67 ro root=LABEL=/1 console=ttyS0
>    [Linux-bzImage, setup=0x1400, size=0xe1aaf]
> initrd /boot/initrd-2.5.67.img
>    [Linux-initrd @ 0xffc7000, 0x14ffb bytes]

Dave, since your ISP is blocking my mail, I reply on lkml...

I booted fine the 2.5 kernel by tagging it for netboot and
then placing it on my tftp directory. I never use harddisk
bootloaders, so if you can not make it work with grub,
I would get ahead and make it boot from floppy. Yes, it
takes a minute to load a kernel, but it works and is simple.

I use syslinux for that, it's fairly simple and you can
enter kernel options directly at the boot prompt.

Also, since it's a dos 8.3-formatted floppy, you can upgrade
your kernel by simply replacing the kernel file.

If you need a dos-formatted empty disk, I can post one to my
homepage for you to download.

Greets, Antonio.

ps. I'm having problems with running "make menuconfig" on rh9
    under vanilla 2.5.66, the gnome-terminal hangs easily...
    any ideas? (Yes, I'll try xterm or rxvt just in case).
