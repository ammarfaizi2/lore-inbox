Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUBTJlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267763AbUBTJlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:41:15 -0500
Received: from [62.47.73.173] ([62.47.73.173]:21548 "EHLO flatline.ath.cx")
	by vger.kernel.org with ESMTP id S267748AbUBTJlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:41:01 -0500
Date: Fri, 20 Feb 2004 10:40:58 +0100
From: Andreas Happe <andreashappe@gmx.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [radeonfb] black screen/wrong display size detected
Message-ID: <20040220094057.GA1188@flatline.ath.cx>
References: <slrnc375fh.145.andreashappe@flatline.ath.cx> <1077165057.20787.239.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1077165057.20787.239.camel@gaston>
User-Agent: Mutt/1.4.2.1i
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> [040220 10:00]:
>On Thu, 2004-02-19 at 03:42, Andreas Happe wrote:
>Is backlight off or is it enabled and just screen content is
>black ?

The screen content is black, I can change the backlight intensitivity
with my keyboard.

>> wrong size detected, display is 1680x1050.
>
>That's interesting. 
>
>Enable radeon debug options and send me the output.

| PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
| radeonfb_pci_register BEGIN
| radeonfb: probed DDR SGRAM 65536k videoram
| radeonfb: mapped 16384k videoram
| radeonfb: Found Intel x86 BIOS ROM Image
| radeonfb: Retreived PLL infos from BIOS
| radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=220.00 MHz
| i2c_adapter i2c-0: registered as adapter #0
| i2c_adapter i2c-1: registered as adapter #1
| i2c_adapter i2c-2: registered as adapter #2
| i2c_adapter i2c-3: registered as adapter #3
| 1 chips in connector info
|  - chip 1 has 1 connectors
|   * connector 0 of type 2 (CRT) : 2300
| Starting monitor auto detection...
| radeonfb: I2C (port 1) ... not found
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| radeonfb: I2C (port 2) ... not found
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| radeonfb: I2C (port 3) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| radeonfb: I2C (port 2) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| Non-DDC laptop panel detected
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| radeonfb: I2C (port 3) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| radeonfb: Monitor 1 type LCD found
| radeonfb: Monitor 2 type no found
| radeonfb: panel ID string: Samsung LTN150P1-L02    
| radeonfb: detected LVDS panel size from BIOS: 1400x1050
| BIOS provided panel power delay: 1000
| radeondb: BIOS provided dividers will be used
| ref_divider = c
| post_divider = 1
| fbk_divider = 60
| Scanning BIOS table ...
|  18 x 18665
|  8236 x 21569
|  12598 x 8241
|  0 x 25600
|  19558 x 0
|  65535 x 65535
|  0 x 866
|  65376 x 65535
|  8 x 2048
|  63743 x 3841
|  255 x 0
|  0 x 0
|  65535 x 115
|  32768 x 5
|  4608 x 4608
|  2179 x 2179
|  64770 x 33280
|  3 x 23046

..interessting values.

| Didn't find panel in BIOS table !
| Guessing panel info...
| radeonfb: Assuming panel size 1400x1050
| radeonfb: Power Management enabled for Mobility chipsets
| radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
| radeonfb_pci_register END

>Also try
>commenting out the call to radeon_map_ROM(rinfo, pdev);
>in drivers/video/aty/radeon_base.c and send me that output
>as well (send me both, even if commenting out the call "fixes"
>it).

yes, it fixed the problem for me (I get an working framebuffer, computer
still crashes (sysrq still works) on startup (via xdm)).

kernel output:
| radeonfb_pci_register BEGIN
| radeonfb: probed DDR SGRAM 65536k videoram
| radeonfb: mapped 16384k videoram
| radeonfb: Retreived PLL infos from BIOS
| radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=220.00 MHz
| i2c_adapter i2c-0: registered as adapter #0
| i2c_adapter i2c-1: registered as adapter #1
| i2c_adapter i2c-2: registered as adapter #2
| i2c_adapter i2c-3: registered as adapter #3
| 1 chips in connector info
|  - chip 1 has 1 connectors
|   * connector 0 of type 2 (CRT) : 2300
| Starting monitor auto detection...
| radeonfb: I2C (port 1) ... not found
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| radeonfb: I2C (port 2) ... not found
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| radeonfb: I2C (port 3) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| i2c_adapter i2c-1: master_xfer: with 2 msgs.
| radeonfb: I2C (port 2) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| Non-DDC laptop panel detected
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| i2c_adapter i2c-2: master_xfer: with 2 msgs.
| radeonfb: I2C (port 3) ... not found
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| i2c_adapter i2c-3: master_xfer: with 2 msgs.
| radeonfb: I2C (port 4) ... not found
| radeonfb: Monitor 1 type LCD found
| radeonfb: Monitor 2 type no found
| radeonfb: panel ID string: HTC                     
| radeonfb: detected LVDS panel size from BIOS: 1680x1050
| BIOS provided panel power delay: 1000
| radeondb: BIOS provided dividers will be used
| ref_divider = 6
| post_divider = 1
| fbk_divider = 35
| Scanning BIOS table ...
|  320 x 350
|  320 x 400
|  320 x 400
|  320 x 480
|  400 x 600
|  512 x 384
|  640 x 350
|  640 x 400
|  640 x 475
|  640 x 480
|  720 x 480
|  720 x 576
|  800 x 600
|  848 x 480
|  1024 x 768
|  1280 x 1024
|  1152 x 864
|  1280 x 800
|  1680 x 1050
| Found panel in BIOS table:
|   hblank: 160
|   hOver_plus: 48
|   hSync_width: 32
|   vblank: 30
|   vOver_plus: 2
|   vSync_width: 6
|   clock: 11912
| Setting up default mode based on panel info
| radeonfb: Power Management enabled for Mobility chipsets
| radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
| radeonfb_pci_register END

	--Andreas
