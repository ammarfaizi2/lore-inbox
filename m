Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130606AbQLIJrZ>; Sat, 9 Dec 2000 04:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbQLIJrP>; Sat, 9 Dec 2000 04:47:15 -0500
Received: from manos.timpanogas.org ([207.109.151.249]:39428 "EHLO
	manos.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130606AbQLIJrE>; Sat, 9 Dec 2000 04:47:04 -0500
Date: Sat, 9 Dec 2000 03:12:15 -0700
From: root <root@manos.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: 2.2.18-25 Video Sickness
Message-ID: <20001209031215.A6064@manos.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here is the .config file section for turning on the console drivers
for 2.2.18-25 that causes the sickness with Xconfigurator.

Jeff

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
# CONFIG_FB_PM2_PCI is not set
CONFIG_FB_ATY=y
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
