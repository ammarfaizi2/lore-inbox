Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTIOVE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbTIOVE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:04:27 -0400
Received: from ns.suse.de ([195.135.220.2]:3285 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261606AbTIOVEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:04:23 -0400
Date: Mon, 15 Sep 2003 23:04:21 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?utf-8?Q?Dani=C3=ABl?= Mantione <daniel@deadlock.et.tudelft.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
Message-ID: <20030915210421.GA311@suse.de>
References: <3F631113.4C6368D3@eyal.emu.id.au> <Pine.GSO.4.21.0309131622000.2634-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.21.0309131622000.2634-100000@vervain.sonytel.be>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pre4 doesnt work on my ibook1, the xclk value is 125, but should be 50.


Linux version 2.4.20 (2.4.20-ben8@PowerPC.suse.de) (gcc version 3.2.2 20030314 (prerelease) (SuSE Linux)) #2 Tue Mar 18 17:19:27 UTC 2003

atyfb: using auxiliary register aperture
atyfb: 3D RAGE Mobility (AGP) [0x4c4e rev 0x64] 4M WRAM, 14.31818 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
Registered "ati" backlight controller, level: 15/15
atyfb: monitor sense=0, mode 20
Console: switching to colour frame buffer device 100x37
fb0: ATY Mach64 frame buffer device on PCI

Linux version 2.4.23-pre4-ibook1 (builds@ibook) (gcc version 3.2.3 (SuSE Linux)) #6 Mon Sep 15 21:54:16 CEST 2003

atyfb: using auxiliary register aperture
atyfb: 3D RAGE Mobility (AGP) [0x4c4e rev 0x64] 4M WRAM, 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
atyfb: monitor sense=0, mode 20
Console: switching to colour frame buffer device 100x37
fb0: ATY Mach64 frame buffer device on PCI

mango:~ # lspci
00:0b.0 Host bridge: Apple Computer Inc. UniNorth AGP
00:10.0 VGA compatible controller: ATI Technologies Inc Rage Mobility L AGP 2x (rev 64)
10:0b.0 Host bridge: Apple Computer Inc. UniNorth PCI
10:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 02)
10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB
10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB
20:0b.0 Host bridge: Apple Computer Inc. UniNorth Internal PCI
20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun GEM)
mango:~ # lspci -n
00:0b.0 Class 0600: 106b:0020
00:10.0 Class 0300: 1002:4c4e (rev 64)
10:0b.0 Class 0600: 106b:001f
10:17.0 Class ff00: 106b:0022 (rev 02)
10:18.0 Class 0c03: 106b:0019
10:19.0 Class 0c03: 106b:0019
20:0b.0 Class 0600: 106b:001e
20:0f.0 Class 0200: 106b:0021

(==) ATI(0): Chipset:  "ati".
(==) ATI(0): Depth 16, (==) framebuffer bpp 16
(II) ATI(0): BIOS Data:  BIOSSize=0x0000, ROMTable=0x0000.
(II) ATI(0): BIOS Data:  ClockTable=0x0000, FrequencyTable=0x0000.
(II) ATI(0): BIOS Data:  LCDTable=0x0000, LCDPanelInfo=0x0000.
(II) ATI(0): BIOS Data:  VideoTable=0x0000, HardwareTable=0x0000.
(II) ATI(0): BIOS Data:  I2CType=0x00, Tuner=0x00, Decoder=0x00, Audio=0x0F.
(--) ATI(0): ATI 3D Rage Mobility graphics controller detected.
(--) ATI(0): Chip type 4C4E "LN", version 4, foundry TSMC, class 0, revision 0x01.
(--) ATI(0): AGP bus interface detected.
(--) ATI(0): ATI Mach64 adapter detected.
(!!) ATI(0): For information on using the multimedia capabilities
 of this adapter, please see http://gatos.sf.net.
(--) ATI(0): Internal RAMDAC (subtype 1) detected.
(==) ATI(0): RGB weight 565
(==) ATI(0): Default visual is TrueColor
(==) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): Using Mach64 accelerator CRTC.
(--) ATI(0): 800x600 panel detected.
(--) ATI(0): Panel clock is 39.952 MHz.
(II) ATI(0): Using digital flat panel interface.
(II) ATI(0): Storing hardware cursor image at 0x913FFC00.
(II) ATI(0): Using 8 MB linear aperture at 0x91800000.
(!!) ATI(0): Virtual resolutions will be limited to 4095 kB
 due to linear aperture size and/or placement of hardware cursor image area.
(II) ATI(0): Using Block 0 MMIO aperture at 0x90000400.
(II) ATI(0): Using Block 1 MMIO aperture at 0x90000000.
(II) ATI(0): MMIO write caching enabled.
(--) ATI(0): 4096 kB of SGRAM (2:1) 32-bit detected (using 4095 kB).
(WW) ATI(0): Cannot shadow an accelerated frame buffer.
(II) ATI(0): Engine XCLK 49.883 MHz;  Refresh rate code 2.
(--) ATI(0): Internal programmable clock generator detected.
(--) ATI(0): Reference clock 157.5/11 (14.318) MHz.
(II) ATI(0): Maximum clock: 199.00 MHz


this patch fixes it:


--- ../../linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c      2003-09-13 15:31:31.000000000 +0200
+++ ./drivers/video/aty/atyfb_base.c    2003-09-15 22:53:12.000000000 +0200
@@ -376,7 +376,7 @@ static struct {
 
     /* 3D RAGE Mobility */
     { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
-    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  83, 125, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
+    { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  83, 50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_EXTRA_BRIGHT},
 #endif /* CONFIG_FB_ATY_CT */
 };
 


atyfb: using auxiliary register aperture
atyfb: 3D RAGE Mobility (AGP) [0x4c4e rev 0x64] 4M WRAM, 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK, 50 Mhz XCLK
atyfb: monitor sense=0, mode 20
Console: switching to colour frame buffer device 100x37
fb0: ATY Mach64 frame buffer device on PCI


why do you think 125 is correct for this card?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
