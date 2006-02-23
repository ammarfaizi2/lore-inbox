Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBWUxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBWUxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWBWUxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:53:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47314 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751504AbWBWUxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:53:24 -0500
Date: Thu, 23 Feb 2006 21:53:09 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, tiwai@suse.de, vojtech@suse.cz
Subject: es1371 sound problems
Message-ID: <20060223205309.GA2045@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After problems with SB Live!, I tried getting another PCI card:

0000:03:03.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev
02)

no luck :-(. Now, this is quite a strange machine (dual core), but
does anyone have any clues? I tried OSS driver, and it did not work,
so I went back to ALSA:

Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
input: PS/2 Generic Mouse as /class/input/input3
reset at 0x220 failed!!!
es18xx: [0x220] ESS chip not found
reset at 0x240 failed!!!
es18xx: [0x240] ESS chip not found
reset at 0x260 failed!!!
es18xx: [0x260] ESS chip not found
reset at 0x280 failed!!!
es18xx: [0x280] ESS chip not found
ACPI: PCI Interrupt 0000:03:02.1[A] -> GSI 18 (level, low) -> IRQ 17
acpi_bus-0201 [11] bus_set_power         : Device is not power
manageable
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 19
es1371: codec read timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
codec write timeout at 0x3014 [0x40000000]
codec write timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
es1371: codec read timeout at 0x3014 [0x40000000]
AC'97 0 access is not valid [0x0], removing mixer.
acpi_bus-0201 [11] bus_set_power         : Device is not power
manageable
ACPI: PCI interrupt for device 0000:03:03.0 disabled
ENS1371: probe of 0000:03:03.0 failed with error -5
ALSA device list:
  #1: Brooktree Bt878 at 0xd0001000, irq 17
oprofile: using timer interrupt.

                                                                Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
