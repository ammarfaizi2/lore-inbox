Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268701AbTCAP6o>; Sat, 1 Mar 2003 10:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268737AbTCAP6n>; Sat, 1 Mar 2003 10:58:43 -0500
Received: from sheridan.uel.ac.uk ([161.76.9.2]:13766 "EHLO sheridan.uel.ac.uk")
	by vger.kernel.org with ESMTP id <S268701AbTCAP6n>;
	Sat, 1 Mar 2003 10:58:43 -0500
Date: Sat, 1 Mar 2003 16:09:09 +0000
From: mk <mk@www0.org>
To: linux-kernel@vger.kernel.org
Subject: Problematic Radeon fb on 2.5.63
Message-ID: <20030301160909.GA1604@www0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is Radeon 7500 QW on a VT8363/8365 [KT133/KM133 AGP]

Cursor does not appear on console, fbset changes are most likely
to cause screen corruption or just black screen and what must effect all
fb graphics support, choosing an fbdriver and not fb console support, is
an accepted option (at least on menuconfig) having as a result blank
screen on boot.

However, comparing it to 2.4.x, console change between gettys is faster. 

# Graphics support
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=y
CONFIG_VGA_CONSOLE=y                                          
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
