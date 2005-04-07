Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVDGVYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVDGVYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVDGVXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:23:05 -0400
Received: from waste.org ([216.27.176.166]:51623 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262607AbVDGVWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:22:02 -0400
Date: Thu, 7 Apr 2005 14:20:59 -0700
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [PATCH] update maintainer for /dev/random
Message-ID: <20050407212058.GU3174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted has agreed to let me take over as maintainer of /dev/random and friends.
I've gone ahead and added a line to his entry in CREDITS.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm/drivers/char/random.c
===================================================================
--- mm.orig/drivers/char/random.c	2005-04-06 13:41:34.000000000 -0700
+++ mm/drivers/char/random.c	2005-04-07 14:13:23.000000000 -0700
@@ -1,7 +1,7 @@
 /*
  * random.c -- A strong random number generator
  *
- * Version 1.89, last modified 19-Sep-99
+ * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
  *
  * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
  * rights reserved.
Index: mm/MAINTAINERS
===================================================================
--- mm.orig/MAINTAINERS	2005-04-06 13:42:21.000000000 -0700
+++ mm/MAINTAINERS	2005-04-07 14:13:23.000000000 -0700
@@ -1914,6 +1914,11 @@ M:	corey@world.std.com
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
Index: mm/CREDITS
===================================================================
--- mm.orig/CREDITS	2005-04-06 13:42:09.000000000 -0700
+++ mm/CREDITS	2005-04-07 14:13:25.000000000 -0700
@@ -3299,6 +3299,7 @@ D: Author of the new e2fsck
 D: Author of job control and system call restart code
 D: Author of ramdisk device driver
 D: Author of loopback device driver
+D: Author of /dev/random driver
 S: MIT Room E40-343
 S: 1 Amherst Street
 S: Cambridge, Massachusetts 02139


-- 
Mathematics is the supreme nostalgia of our time.
