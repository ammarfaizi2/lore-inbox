Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWAPRBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWAPRBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWAPRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:01:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51399 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751123AbWAPRBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:01:44 -0500
Subject: PATCH: Remove rtahw.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:05:55 +0000
Message-Id: <1137431155.15553.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rtahw.h linux-2.6.15-git12/drivers/char/rio/rtahw.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rtahw.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rtahw.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,75 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******                R T A    H A R D W A R E
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_rtahw_h_sccs = "@(#)rtahw.h	1.5";
-#endif
-#endif
-
-#define	WATCHDOG_ADDR	((unsigned short *)0x7a00)
-#define RTA_LED_ADDR	((unsigned short *)0x7c00)
-#define SERIALNUM_ADDR	((unsigned char *)0x7809)
-#define LATCH_ADDR      ((unsigned char *)0x7800)
-
-/*
-** Here we define where the cd1400 chips are in memory.
-*/
-#define CD1400_ONE_ADDR		(0x7300)
-#define CD1400_TWO_ADDR		(0x7200)
-#define CD1400_THREE_ADDR	(0x7100)
-#define CD1400_FOUR_ADDR	(0x7000)
-
-/*
-** Define the different types of modules we can have
-*/
-enum module {
-	MOD_BLANK = 0x0f,	/* Blank plate attached */
-	MOD_RS232DB25 = 0x00,	/* RS232 DB25 connector */
-	MOD_RS232RJ45 = 0x01,	/* RS232 RJ45 connector */
-	MOD_RS422DB25 = 0x02,	/* RS422 DB25 connector */
-	MOD_RS485DB25 = 0x03,	/* RS485 DB25 connector */
-	MOD_PARALLEL = 0x04	/* Centronics parallel */
-};
-
-#define TYPE_HOST	0
-#define TYPE_RTA8	1
-#define TYPE_RTA16	2
-
-#define	WATCH_DOG	WATCHDOG_ADDR
-
-/*********** end of file ***********/

