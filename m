Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWAPQmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWAPQmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWAPQmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:42:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8114 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbWAPQmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:42:04 -0500
Subject: PATCH: Remove chan.h from rio driver (unused file)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:46:17 +0000
Message-Id: <1137429977.15553.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/chan.h linux-2.6.15-git12/drivers/char/rio/chan.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/chan.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/chan.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,33 +0,0 @@
-/*
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
-#ifndef _chan_h
-#define _chan_h
-
-#ifndef lint
-#ifdef SCCS
-static char *_rio_chan_h_sccs = "@(#)chan.h	1.1";
-#endif
-#endif
-
-#define Link0   0
-#define Link1   1
-#define Link2   2
-#define Link3   3
-
-#endif

