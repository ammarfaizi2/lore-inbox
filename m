Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDGU4M>; Sat, 7 Apr 2001 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbRDGU4B>; Sat, 7 Apr 2001 16:56:01 -0400
Received: from 209.102.21.2 ([209.102.21.2]:4874 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131886AbRDGUzo>;
	Sat, 7 Apr 2001 16:55:44 -0400
Message-ID: <3ACF4694.E48E5790@goingware.com>
Date: Sat, 07 Apr 2001 16:55:48 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Config files for Compaq Presario 1800T Laptop
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found that kernel 2.4.3 and XFree86 4.0.3 work very well on my
Compaq Presario 1800T laptop.

I did a lot of fiddling to get things just right, so to make things
easer for other Presario 1800 owners I have archived my kernel .config,
lilo.conf and XF86Config files here:

http://goingware.com/laptop/linux/config/

Have you figured out the configuration for some hard-to-figure-out
hardware?  Post the config files on your website!

The only real problem I have is that the DEC 21143 ethernet chip causes
trouble if I do a soft reboot between Windows and any other operating
system.  If I start with Windows 98 and reboot into either Linux or the
BeOS, the ethernet won't work.  If I start with Linux 2.4.3 and reboot
into Windows 98, Windows will hang partway through boot.  Everything
works fine if I power off before I go between Windows and another OS.

I am using the de4x5 driver for the chip.  That and the tulip driver
both claim to offer support for it, but only de4x5 actually works. 
Curiously, at some point I pulled a development version of the tulip.c
driver source off the author's ftp site and compiled it into a 2.2
kernel, and found that it worked fine.  I don't think either driver
works in the stock 2.2 kernels that I've tried.

XFree86 4.0.3 works well with 2D accelleration but not 3D (DRI).  The
ATI Rage 3D Mobility Pro is an AGP 3D accellerated chip but is uses the
Mach64 driver rather than the ati128; I don't think DRI has been done
for Mach64 yet (correct me if it should work, and I'll keep trying).

I can use the atyfb framebuffer driver in unaccellerated mode but not
accellerated.

Regards,

Mike Crawford
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
