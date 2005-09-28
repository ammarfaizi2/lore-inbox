Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVI1A5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVI1A5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbVI1A5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:57:13 -0400
Received: from paegas2.mail-atlas.net ([212.47.13.187]:21511 "EHLO
	paegas2.mail-atlas.net") by vger.kernel.org with ESMTP
	id S965203AbVI1A5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:57:12 -0400
From: "janik holy" <divizion@pobox.sk>
To: linux-kernel@vger.kernel.org
Message-ID: <6c784b3971ca4a3293c1d745feaa6010@pobox.sk>
Date: Wed, 28 Sep 2005 02:57:10 +0200
X-Priority: 3 (Normal)
Subject: intelfb broken ?
X-Confirmation-Reading-To: "janik holy" <divizion@pobox.sk>
MIME-Version: 1.0
Content-type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i have hp compaq nx9020 with Display controller: Intel Corp. 82852/855GM Integrated Graphics Device (rev 02), im trying run console with framebuffer -> intelfb, in kernel 2.6.11, and vga=792, all work ok, just cursor is not visible. In all kernel > 2.6.11, vga=792, my laptop just booting, all should work, but display is all the time blank, nothing is seen.

this is log from 2.6.11, where all work but cursor is not visible, in lilo vga=792, because append=intelfb... is impossible to use if laptop...

intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 32636kB
intelfb: MTRR is disabled in the kernel
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-32@60.
intelfb: Changing the video mode is not supported.
Console: switching to colour frame buffer device 128x48

with > 2.6.11, actually 2.6.13.2 laptop boot, but on display is nothing, just black .. better blank display i try to look at dmesg (by blind)
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chipset
s
intelfb: Version 0.9.2
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ
 10
intelfb: 00:02.0: Intel(R) 852GM, aperture size 128MB, stolen memory 32636kB
intelfb: MTRR is disabled in the kernel
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Initial video mode is 1024x768-32@60.
intelfb: Changing the video mode is not supported.
Console: switching to colour frame buffer device 128x48

then same stuff like in 2.6.11 but dont work ;-/

In kernel i have compiled Graphic support -> * Support for the frame buffer devices -> * Intel 830/....

 Console display and driver support -> * Video mode selection support , * Framebuffer console support

 all this stuff compiled in kernel, not as module.



Any idea where can be problem ? why it doesnt work with new kernel, so its this drivers broken ? Thanks





Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!


