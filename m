Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262388AbTCIDrZ>; Sat, 8 Mar 2003 22:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbTCIDrZ>; Sat, 8 Mar 2003 22:47:25 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4623 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262388AbTCIDrY>; Sat, 8 Mar 2003 22:47:24 -0500
Date: Sun, 9 Mar 2003 04:57:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
cc: Romain Lievin <roms@tilp.info>
Subject: [PATCH] kconfig update
Message-ID: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It took a bit longer than I wanted, but here is finally another kconfig 
update. There are two important changes: I included Romain's gtk front 
end and the support for the menuconfig keyword. Unfortunately the first is 
lacking a bit support for the latter. Romain, you have to check that menu 
entries of type P_MENU can now also have a config symbol. I looked a bit 
at it myself but my gtk knowledge is insufficient. :)
Other changes are small parser fixes and the config list in qconf has a 
parent entry, so it should be more obvious, how to get to a parent menu.
I don't expect bigger problems, so I want to send this patch soon to 
Linus.
The patch is at http://www.xs4all.nl/~zippel/lc/patches/kconfig-2.5.64.diff

bye, Roman

