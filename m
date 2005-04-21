Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVDUSnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVDUSnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDUSnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:43:33 -0400
Received: from shim2.irt.drexel.edu ([144.118.29.72]:61677 "EHLO
	shim2.irt.drexel.edu") by vger.kernel.org with ESMTP
	id S261745AbVDUSn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:43:27 -0400
Date: Thu, 21 Apr 2005 14:43:20 -0400
From: Cosmin Nicolaescu <cos@camelot.homelinux.com>
Subject: [PATCH 2.6.11] Documentation: remove super-{nr,
 max} from the Documentation to reflect fs/super.c
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Message-id: <20050421184320.3951.qmail@camelot.homelinux.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch updates the documentation for /proc. super-nr and super-max have
been dropped from the kernel since 2.4.9 due to minor numbering issues.
This change was not documented in the documentation.

--- linux-2.6.11/Documentation/filesystems/proc.txt     2005-04-14 17:56:00.000000
+++ linux-2.6.11/Documentation/filesystems/proc.txt.orig        2005-04-21 14:14:0
@@ -909,16 +909,6 @@ nr_free_inodes
 Represents the  number of free inodes. Ie. The number of inuse inodes is
 (nr_inodes - nr_free_inodes).
 
-super-nr and super-max
-----------------------
-
-Again, super  block structures are allocated by the kernel, but not freed. The
-file super-max  contains  the  maximum  number  of super block handlers, where
-super-nr shows the number of currently allocated ones.
-
-Every mounted file system needs a super block, so if you plan to mount lots of
-file systems, you may want to increase these numbers.
-
 aio-nr and aio-max-nr
 ---------------------
 
Signed-off-by: Cosmin Nicolaescu <cos@camelot.homelinux.com>
