Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTBTD24>; Wed, 19 Feb 2003 22:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTBTD24>; Wed, 19 Feb 2003 22:28:56 -0500
Received: from mail.cityisp.net ([66.230.219.2]:8464 "EHLO RADIUS.radius")
	by vger.kernel.org with ESMTP id <S264748AbTBTD2z> convert rfc822-to-8bit;
	Wed, 19 Feb 2003 22:28:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: gilson redrick <gilsonr@cityisp.net>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.x freezes on booting
Date: Wed, 19 Feb 2003 22:40:22 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302192240.22261.gilsonr@cityisp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've rechecked my procedures, have gone through the archive without result.

I compiled 2.4.19 and 2.4.20 (which I'm using right now) without problem, but 
2.5.x is, so far, winning over me.

First was 2.5.59, then 2.5.60 and now 2.5.61. With all them, the same 
scenario: make modules and modules_install go without errors; after copying 
System.map and bzImage and creating initrd, I reboot and get six lines of 
text:
    kernel (hd0,8) /boot/vmlinuz-2.5.61 root=/dev/hda9
	devfs=mount hdc=ide-scsi vga=0x0f05
    [Linux-bzImage, setup=0xc00, size=0xa4828]
    initrd (hd0,8) /boot/initrd-2.5.61-img
    [Linux-initrd @ 0xf7da000, 0x5717 bytes]
	Uncompressing Linux ...	Ok, booting the kernel
and the system is frozen; nothing runs, no chance for Ctrl-Alt-Del.

Why 2.4.x works well, and 2.5.x, with the same compling technique, on the same 
hardware, doesn't?

This is a 1.3GHz Duron, one 20GB HD running Mandrake-9.0. No SCSI, USB or any 
fancy additive or appendage (simply because I can't afford them!)

Any word of wisdom will be greatly appreciated. Please CC to me, as I am not 
on the kernel list.

-- 
Regards,

gilson: gilsonr@cityisp.net
(in /usually/ balmy, sunny Florida's Suncoast)
[An Intel-free, M$-free, virus-free computer; not by chance, but by choice: 
powered by MandrakeSoft-9.0 Linux-2.4.20]
