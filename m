Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVDLOQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVDLOQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVDLLJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:09:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:25034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262251AbVDLKdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:11 -0400
Message-Id: <200504121032.j3CAWtlh005717@shell0.pdx.osdl.net>
Subject: [patch 143/198] update maintainer for /dev/random
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mpm@selenic.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Matt Mackall <mpm@selenic.com>

Ted has agreed to let me take over as maintainer of /dev/random and
friends.  I've gone ahead and added a line to his entry in CREDITS.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/CREDITS               |    1 +
 25-akpm/MAINTAINERS           |    5 +++++
 25-akpm/drivers/char/random.c |    2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff -puN CREDITS~update-maintainer-for-dev-random CREDITS
--- 25/CREDITS~update-maintainer-for-dev-random	2005-04-12 03:21:37.782393104 -0700
+++ 25-akpm/CREDITS	2005-04-12 03:21:37.790391888 -0700
@@ -3298,6 +3298,7 @@ D: Author of the new e2fsck
 D: Author of job control and system call restart code
 D: Author of ramdisk device driver
 D: Author of loopback device driver
+D: Author of /dev/random driver
 S: MIT Room E40-343
 S: 1 Amherst Street
 S: Cambridge, Massachusetts 02139
diff -puN drivers/char/random.c~update-maintainer-for-dev-random drivers/char/random.c
--- 25/drivers/char/random.c~update-maintainer-for-dev-random	2005-04-12 03:21:37.784392800 -0700
+++ 25-akpm/drivers/char/random.c	2005-04-12 03:21:37.791391736 -0700
@@ -1,7 +1,7 @@
 /*
  * random.c -- A strong random number generator
  *
- * Version 1.89, last modified 19-Sep-99
+ * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
  *
  * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
  * rights reserved.
diff -puN MAINTAINERS~update-maintainer-for-dev-random MAINTAINERS
--- 25/MAINTAINERS~update-maintainer-for-dev-random	2005-04-12 03:21:37.785392648 -0700
+++ 25-akpm/MAINTAINERS	2005-04-12 03:21:37.793391432 -0700
@@ -1877,6 +1877,11 @@ M:	corey@world.std.com
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+RANDOM NUMBER DRIVER
+P:	Matt Mackall
+M:	mpm@selenic.com
+S:	Maintained
+
 REAL TIME CLOCK DRIVER
 P:	Paul Gortmaker
 M:	p_gortmaker@yahoo.com
_
