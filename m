Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSBDLxm>; Mon, 4 Feb 2002 06:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSBDLxd>; Mon, 4 Feb 2002 06:53:33 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:20497 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288923AbSBDLxV>; Mon, 4 Feb 2002 06:53:21 -0500
Date: Mon, 4 Feb 2002 10:01:42 -0200
From: Marinho Paiva Duarte <mpd_kernel@yahoo.com>
To: Fabrice Eudes <fabrice.eudes@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot 2.4.17 or 2.5.1 kernel
Message-Id: <20020204100142.384b9d52.mpd_kernel@yahoo.com>
In-Reply-To: <20020204113949.A1695@corwin.ambre.fr>
In-Reply-To: <20020204113949.A1695@corwin.ambre.fr>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-Red Hat GNU/Linux 7.1)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
You must upgrade the modutils and other related packages.
Take a look at debian news and see the packages that Bunk had prepared
to use Debian 2.2 with 2.4.x kernels.
I think it will solve your problem.

Best Regards,
Marinho Paiva Duarte


On Mon, 4 Feb 2002 11:39:49 +0100
Fabrice Eudes <fabrice.eudes@free.frwrote:

Hello,

I am a french guy living in Lille and using/practising Linux for
6ish years. Please could you Cc me any answer. thanks a lot.

I had a -long- look in the mailing list archives but couldn't find
an answer to the following question:

[Short] I boot 2.2.19 kernels without any problems but can't boot
any 2.4.17 neither a 2.5.1.

[Details] I have a PC Packard-Bell imédia6007a
- AMD Athlon 1.4GHz
- Motherboard "Explorer" from Packard-Bell
- Chipset VIA KM133: VT8365A Northbridge (AGP,PCI) and VT686B
  Southbridge (IDE,USB) (BIOS recently upgraded)
- ATIRadeonVE 32MB
- Debian GNU/Linux Woody (non-official isos from 20/07/2001) with
  XFree86 upgraded from 4.0.3 to 4.1.0 (xfree86-common,
  xserver-common, xserver-xfree86) for radeon support.

Firstly, I want a 2.4.x kernel for the sound (alsa), the framebuffer
and the dri (I'd like to be able to play tuxracer ;o)

I boot my system with grub and there is no problem for the 2.2.19
kernel packaged with the woody neither for the lighter one I
compiled myself from the debian packaged sources.

However, I hadn't any success booting a 2.4.17 kernel; I hadn't
tried every possibility but I tried:
- a 2.4.13 kernel compiled from the "generic" (I mean not the debian
  package, see below) sources.
- the kernel-image-2.4.17-k7_2.4.17-1_i386.deb debian package.
- many kernels compiled from kernel-source-2.4.17_2.4.17-1_all.deb
  debian package.
- a few kernels compiled from the 2.4.17 "generic" sources.
- a 2.5.1 kernel compiled from the "generic" sources (non patched).

I tried to compile for Athlon, PentiumPro, 386 -same behavior
I tried with/out initrd support -same behavior
I tried "mem=nopentium" boot option related to the radeon -same
behavior I also tried lilo and boot disks both for grub and lilo ->
same behavior

please help ! thanks a million.

[begin grub output]
  Booting command-list

root  (hd0,0)
  Filesystem type is ext2fs, partition type 0x83
kernel  /boot/vmlinuz-2.4.17-k7 root=/dev/hda1 ro
  [Linux-bzImage, setup=0x1400, size=0x9b512]
initrd  /boot/initrd.img
  [Linux-initrd @ 0x17cb4000, 0x32c000 bytes]

Uncompressing Linux... Ok, booting the kernel.
[end grub output]
and the machine is stucked there...
It seems to me that grub loads the kernel ok but when grub gives it
the hand, the problem occurs...
-- 
Stéphanie, Fabrice et Fiona	 -o)
stephanie.dupuis@free.fr	 /\\
fabrice.eudes@free.fr		_\_V

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

