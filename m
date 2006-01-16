Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWAPQtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWAPQtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAPQtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:49:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40415 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751102AbWAPQte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:49:34 -0500
Subject: PATCH: Remove internal firmware building files from rio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 16:53:38 +0000
Message-Id: <1137430418.15553.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/lrt.h linux-2.6.15-git12/drivers/char/rio/lrt.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/lrt.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/lrt.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,52 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      L R T
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
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_lrt_h_sccs = "@(#)lrt.h	1.1";
-#endif
-#endif
-
-
-#ifdef DCIRRUS
-#define LRT_STACK       (unsigned short) 600
-#else
-#define LRT_STACK        (ushort) 200
-#endif
-
-
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/ltt.h linux-2.6.15-git12/drivers/char/rio/ltt.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/ltt.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/ltt.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,52 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      L T T
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
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_ltt_h_sccs = "@(#)ltt.h	1.1";
-#endif
-#endif
-
-#ifdef DCIRRUS
-#define LTT_STACK       (unsigned short)  600
-#else
-#define LTT_STACK       (ushort) 200
-#endif
-
-
-
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/lttwake.h linux-2.6.15-git12/drivers/char/rio/lttwake.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/lttwake.h	2006-01-16 14:19:12.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/lttwake.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,50 +0,0 @@
-
-
-
-/****************************************************************************
- *******                                                              *******
- *******            L T T    W A K E U P    H E A D E R
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
-static char *_rio_lttwake_h_sccs = "@(#)lttwake.h	1.1";
-#endif
-#endif
-
-#define LTT_WAKEUP_STACK          500
-#define LTT_WAKEUP_INTERVAL       (int) (500 * MILLISECOND)
-
-
-/*********** end of file ***********/

