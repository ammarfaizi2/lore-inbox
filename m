Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUGOUhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUGOUhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGOUhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:37:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42464 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266237AbUGOUhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:37:25 -0400
Date: Thu, 15 Jul 2004 22:37:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [patch] remove bouncing email addresses of Marko Kiiskila
Message-ID: <20040715203717.GG25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to Cc Marko Kiiskila when sending a patch that affects a file 
where his email address is in the header.

Unfortunately, both of his email addresses in the kernel sources are 
bouncing.

Unless someone knows a current address of Marko, I'd suggest the patch 
below to remove the outdated addresses.

diffstat output:
 CREDITS                |    1 -
 include/linux/atmlec.h |    2 +-
 net/atm/lec.c          |    2 +-
 net/atm/lec.h          |    2 +-
 net/atm/lec_arpc.h     |    2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-full/include/linux/atmlec.h.old	2004-07-15 22:21:34.000000000 +0200
+++ linux-2.6.8-rc1-full/include/linux/atmlec.h	2004-07-15 22:22:32.000000000 +0200
@@ -2,7 +2,7 @@
  * 
  * ATM Lan Emulation Daemon vs. driver interface
  *
- * carnil@cs.tut.fi
+ * Marko Kiiskila
  *
  */
 
--- linux-2.6.8-rc1-full/net/atm/lec.h.old	2004-07-15 22:21:34.000000000 +0200
+++ linux-2.6.8-rc1-full/net/atm/lec.h	2004-07-15 22:22:41.000000000 +0200
@@ -2,7 +2,7 @@
  *
  * Lan Emulation client header file
  *
- * Marko Kiiskila carnil@cs.tut.fi
+ * Marko Kiiskila
  *
  */
 
--- linux-2.6.8-rc1-full/net/atm/lec.c.old	2004-07-15 22:21:34.000000000 +0200
+++ linux-2.6.8-rc1-full/net/atm/lec.c	2004-07-15 22:22:47.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  * lec.c: Lan Emulation driver 
- * Marko Kiiskila carnil@cs.tut.fi
+ * Marko Kiiskila
  *
  */
 
--- linux-2.6.8-rc1-full/net/atm/lec_arpc.h.old	2004-07-15 22:21:34.000000000 +0200
+++ linux-2.6.8-rc1-full/net/atm/lec_arpc.h	2004-07-15 22:22:59.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  * Lec arp cache
- * Marko Kiiskila carnil@cs.tut.fi
+ * Marko Kiiskila
  *
  */
 #ifndef _LEC_ARP_H
--- linux-2.6.8-rc1-full/CREDITS.old	2004-07-15 22:21:34.000000000 +0200
+++ linux-2.6.8-rc1-full/CREDITS	2004-07-15 22:23:09.000000000 +0200
@@ -1633,7 +1633,6 @@
 S: United Kingdom
 
 N: Marko Kiiskila
-E: marko@iprg.nokia.com
 D: Author of ATM Lan Emulation
 S: 660 Harvard Ave. #7
 S: Santa Clara, CA 95051

