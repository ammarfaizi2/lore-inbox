Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJAQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJAQVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:45 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:45205 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262395AbTJAQS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:18:59 -0400
Subject: [PATCH] [TRIVIAL 2/12] 2.6.0-test6-bk remove reference to
	modules.txt in drivers/md/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025076.1995.2392.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:17:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

Steven

--- 2.6-bk-current/drivers/md/Kconfig	2003-09-30 21:04:27.000000000 -0600
+++ linux/drivers/md/Kconfig	2003-09-30 21:40:46.000000000 -0600
@@ -38,10 +38,8 @@
 	  use the so-called linear mode, i.e. it will combine the hard disk
 	  partitions by simply appending one to the other.
 
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called linear.
+	  To compile this driver as a module, choose M here: the
+	  module will be called linear.
 
 	  If unsure, say Y.
 
@@ -60,10 +58,8 @@
 	  <http://www.tldp.org/docs.html#howto>. There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called raid0.
+	  To compile this driver as a module, choose M here: the
+	  module will be called raid0.
 
 	  If unsure, say Y.
 
@@ -84,11 +80,10 @@
 	  <http://www.tldp.org/docs.html#howto>.  There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
-	  If you want to use such a RAID-1 set, say Y. This code is also
-	  available as a module called raid1 ( = code which can be inserted
-	  in and removed from the running kernel whenever you want).  If you
-	  want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  If you want to use such a RAID-1 set, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called raid1.
 
 	  If unsure, say Y.
 
@@ -109,11 +104,10 @@
 	  <http://www.tldp.org/docs.html#howto>. There you will also
 	  learn where to get the supporting user space utilities raidtools.
 
-	  If you want to use such a RAID-4/RAID-5 set, say Y. This code is
-	  also available as a module called raid5 ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  If you want to compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
+	  If you want to use such a RAID-4/RAID-5 set, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called raid5.
 
 	  If unsure, say Y.
 
@@ -140,8 +134,8 @@
 
 	  Higher level volume managers such as LVM2 use this driver.
 
-	  If you want to compile this as a module, say M here and read 
-	  <file:Documentation/modules.txt>.  The module will be called dm-mod.
+	  To compile this driver as a module, choose M here: the
+	  module will be called dm-mod.
 
 	  If unsure, say N.
 







