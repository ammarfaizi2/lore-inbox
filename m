Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTGOFdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTGOFdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:33:10 -0400
Received: from [203.199.140.162] ([203.199.140.162]:13830 "EHLO
	calvin.codito.com") by vger.kernel.org with ESMTP id S262589AbTGOFdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:33:02 -0400
From: Amit Shah <shahamit@gmx.net> (by way of Amit Shah
	<shahamit@gmx.net>)
Subject: 2.6.0-test1: Framebuffer problem
Date: Tue, 15 Jul 2003 11:17:55 +0530
User-Agent: KMail/1.5.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151117.55804.shahamit@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Riva TNT2 display card. On compiling in framebuffer support and
 the other options (like the fonts, vga16 support, etc, relevant part of
 .config pasted below), the kernel doesn't proceed after some messages
 (where it initializes the frame buffer)... I just see the grub screen
 again with some stripes and there's no disk activity thereafter.

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y


--
Amit Shah
http://amitshah.nav.to/

Why do you want to read your code?
 The machine will.
                 -- Sunil Beta

