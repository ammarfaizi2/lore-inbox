Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWAPQlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWAPQlL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWAPQlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:41:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7346 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751002AbWAPQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:41:09 -0500
Subject: PATCH: Removed cmd.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:45:18 +0000
Message-Id: <1137429918.15553.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/cmd.h linux-2.6.15-git12/drivers/char/rio/cmd.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/cmd.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/cmd.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,83 +0,0 @@
-
-
-/****************************************************************************
- *******                                                              *******
- *******           C O M M A N D   P A C K E T   H E A D E R S
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
-
-#ifndef _cmd_h
-#define _cmd_h
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_cmd_h_sccs = "@(#)cmd.h	1.1";
-#endif
-#endif
-
-
-#define PRE_EMPTIVE_CMD         0x80
-#define INLINE_CMD              ~PRE_EMPTIVE_CMD
-
-#define CMD_IGNORE_PKT          ( (ushort) 0)
-#define CMD_STATUS_REQ          ( (ushort) 1)
-#define CMD_UNIT_STATUS_REQ     ( (ushort) 2)	/* Is this needed ??? */
-#define CMD_CONF_PORT           ( (ushort) 3)
-#define CMD_CONF_UNIT           ( (ushort) 4)
-#define CMD_ROUTE_MAP_REQ       ( (ushort) 5)
-#define CMD_FLUSH_TX            ( (ushort) 6)
-#define CMD_FLUSH_RX            ( (ushort) 7)
-#define CMD_PARTION_PORT        ( (ushort) 8)
-#define CMD_RESET_PORT          ( (ushort) 0x0a)
-#define CMD_BOOT_UNIT           ( (ushort) 0x0b)
-#define CMD_FOUND_UNIT          ( (ushort) 0x0c)
-#define CMD_ATTACHED_RTA_2      ( (ushort) 0x0d)
-#define CMD_PROVIDE_BOOT        ( (ushort) 0x0e)
-#define CMD_CIRRUS              ( (ushort) 0x0f)
-
-#define FORM_STATUS_PKT         ( (ushort) 1 )
-#define FORM_POLL_PKT           ( (ushort) 2 )
-#define FORM_LINK_STATUS_PKT    ( (ushort) 3 )
-
-
-#define CMD_DATA_PORT           ( (ushort) 1 )
-#define CMD_DATA                ( (ushort) 2 )
-
-#define CMD_TX_PART             ( (ushort) 2 )
-#define CMD_RX_PART             ( (ushort) 3 )
-#define CMD_RX_LIMIT            ( (ushort) 4 )
-
-#endif
-
-/*********** end of file ***********/

