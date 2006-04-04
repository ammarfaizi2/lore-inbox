Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWDDFSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWDDFSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 01:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDDFSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 01:18:51 -0400
Received: from stark.xeocode.com ([216.58.44.227]:43469 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S964921AbWDDFSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 01:18:50 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: atyfb doesn't work for me
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 04 Apr 2006 01:18:44 -0400
Message-ID: <87irppc40b.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to load atyfb I get messages about "unsupported xclk source" and
"vclk out of range" and the fb devices don't seem to be active. That is, 
  fbset -fb /dev/fb?
all say "no such device"

I see there are module parameters to override some of these settings but I'm
not clear where I would find the correct values to use. And surely the fb
driver ought to be able to come up usable values on its own?


[   25.724880] PCI: Enabling device 0000:02:0b.0 (0080 -> 0083)
[   25.724943] ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 23 (level, low) -> IRQ 18
[   25.725047] atyfb: using auxiliary register aperture
[   25.725125] atyfb: 3D RAGE II (Mach64 GT) [0x4754 rev 0x41]
[   25.725176] atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
[   25.725228] atyfb: BIOS frequency table:
[   25.725281] atyfb: PCLK_min_freq 26465, PCLK_max_freq 24930, ref_freq 11829, ref_divider 12902
[   25.725337] atyfb: MCLK_pwd 12598, MCLK_max_freq 8241, XCLK_max_freq 22016, SCLK_freq 13619
[   25.725418] atyfb: 512K SDRAM (1:1), 14.31818 MHz XTAL, 249 MHz PLL, 82 Mhz MCLK, 220 MHz XCLK
[   25.725473] atyfb: Unsupported xclk source:  5.
[   25.725654] atyfb: vclk out of range
[   25.725703] atyfb: can't set default video mode
[   25.762829] PCI: Enabling device 0000:02:0c.0 (0080 -> 0083)
[   25.762882] ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 19
[   25.762965] atyfb: using auxiliary register aperture
[   25.763020] atyfb: 3D RAGE II+ (Mach64 GU) [0x4755 rev 0x9a]
[   25.763065] atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
[   25.763109] atyfb: BIOS frequency table:
[   25.763150] atyfb: PCLK_min_freq 26465, PCLK_max_freq 24930, ref_freq 11829, ref_divider 12902
[   25.763201] atyfb: MCLK_pwd 12598, MCLK_max_freq 8241, XCLK_max_freq 22016, SCLK_freq 13619
[   25.763276] atyfb: 512K RESV, 14.31818 MHz XTAL, 249 MHz PLL, 82 Mhz MCLK, 220 MHz XCLK
[   25.763326] atyfb: Unsupported xclk source:  5.
[   25.763496] atyfb: vclk out of range
[   25.763541] atyfb: can't set default video mode


-- 
greg

