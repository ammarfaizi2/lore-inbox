Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbTCIMfp>; Sun, 9 Mar 2003 07:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbTCIMfp>; Sun, 9 Mar 2003 07:35:45 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:17421 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262505AbTCIMfo>; Sun, 9 Mar 2003 07:35:44 -0500
Date: Sun, 9 Mar 2003 13:46:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org, Romain Lievin <roms@tilp.info>
Subject: Re: [PATCH] kconfig update
In-Reply-To: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
Message-ID: <Pine.LNX.4.44.0303091344250.32518-100000@serv>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Roman Zippel wrote:

> It took a bit longer than I wanted, but here is finally another kconfig 
> update. There are two important changes: I included Romain's gtk front 
> end and the support for the menuconfig keyword.

BTW here is a simple menuconfig example, if someone wants to know, how it 
looks like:

--- linux-2.5/arch/i386/Kconfig	2003-03-08 22:35:23.000000000 +0100
+++ linux-2.5-lc/arch/i386/Kconfig	2003-03-09 13:35:04.000000000 +0100
@@ -1305,9 +1305,7 @@
 endmenu
 
 
-menu "SCSI device support"
-
-config SCSI
+menuconfig SCSI
 	tristate "SCSI device support"
 	---help---
 	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
@@ -1329,8 +1327,6 @@
 
 source "drivers/scsi/Kconfig"
 
-endmenu
-
 
 menu "Old CD-ROM drivers (not SCSI, not IDE)"
 	depends on ISA

> The patch is at http://www.xs4all.nl/~zippel/lc/patches/kconfig-2.5.64.diff

bye, Roman

