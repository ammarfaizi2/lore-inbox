Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSFJK5f>; Mon, 10 Jun 2002 06:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSFJK5e>; Mon, 10 Jun 2002 06:57:34 -0400
Received: from gw.whb.pl ([62.89.113.66]:38411 "HELO smtp.whb.pl")
	by vger.kernel.org with SMTP id <S314491AbSFJK5d>;
	Mon, 10 Jun 2002 06:57:33 -0400
X-Qmail-Scanner-Mail-From: mbajko@whb.pl via whb.pl
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.118567 secs)
Content-Type: text/plain; charset=US-ASCII
From: Marcin Bajko <mbajko@whb.pl>
Reply-To: mbajko@whb.pl
To: linux-kernel@vger.kernel.org
Subject: Problem with framebuffer for ATI Rage Mobility P/M AGP (kernel 2.4.18)
Date: Mon, 10 Jun 2002 12:57:31 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020610105733Z314491-22020+1558@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have trouble with ATI Rage Mobility P/M AGP graphic card in TravelMate 
525TX laptop.

I want to use framebuffer driver for console but I see black screen only.
I can change resolution by "fbset", all works fine but screen is still black.

Please help...

Marcin



dmesg:
atyfb: using auxiliary register aperture
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 
230 MHz PLL, 50 Mhz MCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI

Kernel 2.4.18 compiled with options:
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

lspci:
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 
2x (rev 64) (prog-if 00 [VGA])
        Subsystem: Acer Incorporated [ALI]: Unknown device 1010
        Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
        Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
        I/O ports at 8000 [size=256]
        Memory at 80600000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 80620000 [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
        Capabilities: [5c] Power Management version 1
