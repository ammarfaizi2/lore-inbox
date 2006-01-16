Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWAPQsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAPQsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAPQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:48:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39647 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbWAPQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:48:37 -0500
Subject: PATCH: Remove hosthw.h from rio (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:52:36 +0000
Message-Id: <1137430356.15553.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/hosthw.h linux-2.6.15-git12/drivers/char/rio/hosthw.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/hosthw.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/hosthw.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,55 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                H O S T      H A R D W A R E
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra / Jeremy Rolls
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
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_hosthw_h_sccs = "@(#)hosthw.h	1.2";
-#endif
-#endif
-
-#define SET_OTHER_INTERRUPT  ( (volatile u_short *) 0x7c80 )
-#define SET_EISA_INTERRUPT  ( (volatile u_short *) 0x7ef0 )
-
-#define EISA_HOST    0x30
-#define AT_HOST      0xa0
-#define MCA_HOST     0xb0
-#define PCI_HOST     0xd0
-
-#define PRODUCT_MASK 0xf0
-
-
-/*********** end of file ***********/

