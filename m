Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWF2GBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWF2GBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWF2GBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:01:47 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:31242 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932211AbWF2GBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:01:46 -0400
Date: Thu, 29 Jun 2006 02:00:52 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] Kconfig: Typos in fs/Kconfig
Message-Id: <20060629020052.f73d7ca1.laplam@rpi.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 02:01:02 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 02:01:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several typos in fs/Kconfig

-
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

--

--- b/fs/Kconfig	2006-06-29 01:35:36.000000000 -0400
+++ a/fs/Kconfig	2006-06-29 01:58:52.000000000 -0400
@@ -69,7 +69,7 @@
 	default y
 
 config EXT3_FS
-	tristate "Ext3 journalling file system support"
+	tristate "Ext3 journaling file system support"
 	select JBD
 	help
 	  This is the journaling version of the Second extended file system
@@ -831,7 +831,7 @@
 
 	Some system agents rely on the information in sysfs to operate.
 	/sbin/hotplug uses device and object attributes in sysfs to assist in
-	delegating policy decisions, like persistantly naming devices.
+	delegating policy decisions, like persistently naming devices.
 
 	sysfs is currently used by the block subsystem to mount the root
 	partition.  If sysfs is disabled you must specify the boot device on
@@ -1036,7 +1036,7 @@
 	  module will be called efs.
 
 config JFFS_FS
-	tristate "Journalling Flash File System (JFFS) support"
+	tristate "Journaling Flash File System (JFFS) support"
 	depends on MTD
 	help
 	  JFFS is the Journaling Flash File System developed by Axis
@@ -1059,13 +1059,13 @@
 	  to be made available to the user in the /proc/fs/jffs/ directory.
 
 config JFFS2_FS
-	tristate "Journalling Flash File System v2 (JFFS2) support"
+	tristate "Journaling Flash File System v2 (JFFS2) support"
 	select CRC32
 	depends on MTD
 	help
-	  JFFS2 is the second generation of the Journalling Flash File System
+	  JFFS2 is the second generation of the Journaling Flash File System
 	  for use on diskless embedded devices. It provides improved wear
-	  levelling, compression and support for hard links. You cannot use
+	  leveling, compression and support for hard links. You cannot use
 	  this on normal block devices, only on 'MTD' devices.
 
 	  Further information on the design and implementation of JFFS2 is
@@ -1209,7 +1209,7 @@
 config JFFS2_CMODE_PRIORITY
         bool "priority"
         help
-          Tries the compressors in a predefinied order and chooses the first
+          Tries the compressors in a predefined order and chooses the first
           successful one.
 
 config JFFS2_CMODE_SIZE
@@ -1892,7 +1892,7 @@
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
 
-	  See <file:Documentation/filesystems/afs.txt> for more intormation.
+	  See <file:Documentation/filesystems/afs.txt> for more information.
 
 	  If unsure, say N.
 

