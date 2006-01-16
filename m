Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWAPQoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWAPQoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAPQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:44:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29594 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751091AbWAPQn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:43:59 -0500
Subject: PATCH: Remove debug.h from rio.h (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:48:12 +0000
Message-Id: <1137430093.15553.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/debug.h linux-2.6.15-git12/drivers/char/rio/debug.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/debug.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/debug.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,39 +0,0 @@
-/*
-** File:		debug.h
-**
-** Author:		David Dix
-**
-** Created:		12th March 1993
-**
-** Last modified:	93/04/27
-**
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
-*/
-
-#ifndef _debug_h_
-#define _debug_h_
-
-
-#if defined(DCIRRUS)
-#define	DBPACKET(pkt, opt, str, chn) 	debug_packet((pkt), (opt), (str), (chn))
-#else
-#define	DBPACKET(pkt, opt, str, c)
-#endif				/* DCIRRUS */
-
-
-#endif				/* _debug_h_ */

