Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbUBRQoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUBRQoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:44:32 -0500
Received: from main.gmane.org ([80.91.224.249]:63705 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265989AbUBRQmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:42:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: [radeonfb] black screen/wrong display size detected
Date: Wed, 18 Feb 2004 17:42:25 +0100
Message-ID: <slrnc375fh.145.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 62.47.73.173
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

display turns black after loading radeon on bootup (compiled in). It
stays black, even after xdm should have started.

hardware: 	HP Compaq nx7000
			01:00.0 VGA compatible controller: ATI Technologies Inc
			Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)

partial dmesg output:
| Linux version 2.6.3-mm1 (crow@flatline.ath.cx) (gcc version 3.3.2) #7 Wed Feb 18 11:49:15 CET 2004
| [..]
| ACPI: RSDP (v000 COMPAQ                                    ) @ 0x000f6350
| ACPI: RSDT (v001 HP     CPQ0860  0x30090320 CPQ  0x00000001) @ 0x1fff0c84
| ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
| ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5bd7
| ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
| ACPI: PM-Timer IO Port: 0x1008
| Built 1 zonelists
| Local APIC disabled by BIOS -- reenabling.
| Found and enabled local APIC!
| Initializing CPU#0
| Kernel command line: root=/dev/hda2 idebus=66 nmi_watchdog=2 mem=524096K
| [..]
| radeonfb: Found Intel x86 BIOS ROM Image
| radeonfb: Retreived PLL infos from BIOS
| radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=220.00 MHz
| i2c_adapter i2c-0: registered as adapter #0
| i2c_adapter i2c-1: registered as adapter #1
| i2c_adapter i2c-2: registered as adapter #2
| i2c_adapter i2c-3: registered as adapter #3
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| Non-DDC laptop panel detected
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: Monitor 1 type LCD found
| radeonfb: Monitor 2 type no found
| radeonfb: panel ID string: Samsung LTN150P1-L02    
| radeonfb: detected LVDS panel size from BIOS: 1400x1050

wrong size detected, display is 1680x1050.

| radeondb: BIOS provided dividers will be used
| radeonfb: Assuming panel size 1400x1050
| radeonfb: Power Management enabled for Mobility chipsets
| radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
| Machine check exception polling timer started.

-- 
Andreas

