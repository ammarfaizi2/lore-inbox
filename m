Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVKRECV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVKRECV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVKRECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:02:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7943 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932464AbVKRECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:02:20 -0500
Date: Fri, 18 Nov 2005 05:02:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rdunlap@xenotime.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] update the email address of Randy Dunlap
Message-ID: <20051118040219.GA11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes all references to the bouncing address 
rddunlap@osdl.org and one dead web page from the kernel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/block/biodoc.txt          |    2 +-
 Documentation/scsi/scsi_mid_low_api.txt |    2 +-
 MAINTAINERS                             |    3 +--
 drivers/usb/class/usblp.c               |    2 +-
 fs/ntfs/ChangeLog                       |    2 +-
 kernel/configs.c                        |    2 +-
 scripts/binoffset.c                     |    2 +-
 scripts/checkversion.pl                 |    2 +-
 scripts/patch-kernel                    |    4 ++--
 9 files changed, 10 insertions(+), 11 deletions(-)

--- linux-2.6.15-rc1-mm1-full/MAINTAINERS.old	2005-11-18 04:51:49.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/MAINTAINERS	2005-11-18 04:52:44.000000000 +0100
@@ -1463,7 +1463,6 @@
 L:	kernel-janitors@osdl.org
 W:	http://www.kerneljanitors.org/
 W:	http://sf.net/projects/kernel-janitor/
-W:	http://developer.osdl.org/rddunlap/kj-patches/
 S:	Maintained
 
 KGDB FOR I386 PLATFORM
@@ -1484,7 +1483,7 @@
 P:	Eric Biederman
 P:	Randy Dunlap
 M:	ebiederm@xmission.com
-M:	rddunlap@osdl.org
+M:	rdunlap@xenotime.net
 W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org
--- linux-2.6.15-rc1-mm1-full/Documentation/block/biodoc.txt.old	2005-11-18 04:52:56.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/Documentation/block/biodoc.txt	2005-11-18 04:53:13.000000000 +0100
@@ -31,7 +31,7 @@
 document:
 	Christoph Hellwig <hch@infradead.org>
 	Arjan van de Ven <arjanv@redhat.com>
-	Randy Dunlap <rddunlap@osdl.org>
+	Randy Dunlap <rdunlap@xenotime.net>
 	Andre Hedrick <andre@linux-ide.org>
 
 The following people helped with fixes/contributions to the bio patches
--- linux-2.6.15-rc1-mm1-full/Documentation/scsi/scsi_mid_low_api.txt.old	2005-11-18 04:53:22.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/Documentation/scsi/scsi_mid_low_api.txt	2005-11-18 04:54:26.000000000 +0100
@@ -1433,7 +1433,7 @@
         Christoph Hellwig <hch at infradead dot org>
         Doug Ledford <dledford at redhat dot com>
         Andries Brouwer <Andries dot Brouwer at cwi dot nl>
-        Randy Dunlap <rddunlap at osdl dot org>
+        Randy Dunlap <rdunlap at xenotime dot net>
         Alan Stern <stern at rowland dot harvard dot edu>
 
 
--- linux-2.6.15-rc1-mm1-full/drivers/usb/class/usblp.c.old	2005-11-18 04:54:51.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/usb/class/usblp.c	2005-11-18 04:55:15.000000000 +0100
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 1999 Michael Gee	<michael@linuxspecific.com>
  * Copyright (c) 1999 Pavel Machek	<pavel@suse.cz>
- * Copyright (c) 2000 Randy Dunlap	<rddunlap@osdl.org>
+ * Copyright (c) 2000 Randy Dunlap	<rdunlap@xenotime.net>
  * Copyright (c) 2000 Vojtech Pavlik	<vojtech@suse.cz>
  # Copyright (c) 2001 Pete Zaitcev	<zaitcev@redhat.com>
  # Copyright (c) 2001 David Paschal	<paschal@rcsis.com>
--- linux-2.6.15-rc1-mm1-full/fs/ntfs/ChangeLog.old	2005-11-18 04:55:27.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/fs/ntfs/ChangeLog	2005-11-18 04:55:40.000000000 +0100
@@ -884,7 +884,7 @@
 
 	- Add handling for initialized_size != data_size in compressed files.
 	- Reduce function local stack usage from 0x3d4 bytes to just noise in
-	  fs/ntfs/upcase.c. (Randy Dunlap <rddunlap@osdl.ord>)
+	  fs/ntfs/upcase.c. (Randy Dunlap <rdunlap@xenotime.net>)
 	- Remove compiler warnings for newer gcc.
 	- Pages are no longer kmapped by mm/filemap.c::generic_file_write()
 	  around calls to ->{prepare,commit}_write.  Adapt NTFS appropriately
--- linux-2.6.15-rc1-mm1-full/kernel/configs.c.old	2005-11-18 04:55:50.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/kernel/configs.c	2005-11-18 04:56:00.000000000 +0100
@@ -3,7 +3,7 @@
  * Echo the kernel .config file used to build the kernel
  *
  * Copyright (C) 2002 Khalid Aziz <khalid_aziz@hp.com>
- * Copyright (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+ * Copyright (C) 2002 Randy Dunlap <rdunlap@xenotime.net>
  * Copyright (C) 2002 Al Stone <ahs3@fc.hp.com>
  * Copyright (C) 2002 Hewlett-Packard Company
  *
--- linux-2.6.15-rc1-mm1-full/scripts/binoffset.c.old	2005-11-18 04:56:10.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/scripts/binoffset.c	2005-11-18 04:56:20.000000000 +0100
@@ -1,6 +1,6 @@
 /***************************************************************************
  * binoffset.c
- * (C) 2002 Randy Dunlap <rddunlap@osdl.org>
+ * (C) 2002 Randy Dunlap <rdunlap@xenotime.net>
 
 #   This program is free software; you can redistribute it and/or modify
 #   it under the terms of the GNU General Public License as published by
--- linux-2.6.15-rc1-mm1-full/scripts/checkversion.pl.old	2005-11-18 04:56:31.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/scripts/checkversion.pl	2005-11-18 04:56:42.000000000 +0100
@@ -3,7 +3,7 @@
 # checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
 # UTS_RELEASE without including <linux/version.h>, or cases of
 # including <linux/version.h> that don't need it.
-# Copyright (C) 2003, Randy Dunlap <rddunlap@osdl.org>
+# Copyright (C) 2003, Randy Dunlap <rdunlap@xenotime.net>
 
 $| = 1;
 
--- linux-2.6.15-rc1-mm1-full/scripts/patch-kernel.old	2005-11-18 04:56:50.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/scripts/patch-kernel	2005-11-18 04:57:06.000000000 +0100
@@ -45,7 +45,7 @@
 # update usage message;
 # fix some whitespace damage;
 # be smarter about stopping when current version is larger than requested;
-#	Randy Dunlap <rddunlap@osdl.org>, 2004-AUG-18.
+#	Randy Dunlap <rdunlap@xenotime.net>, 2004-AUG-18.
 #
 # Add better support for (non-incremental) 2.6.x.y patches;
 # If an ending version number if not specified, the script automatically
@@ -56,7 +56,7 @@
 # patch-kernel does not normally support reverse patching, but does so when
 # applying EXTRAVERSION (x.y) patches, so that moving from 2.6.11.y to 2.6.11.z
 # is easy and handled by the script (reverse 2.6.11.y and apply 2.6.11.z).
-#	Randy Dunlap <rddunlap@osdl.org>, 2005-APR-08.
+#	Randy Dunlap <rdunlap@xenotime.net>, 2005-APR-08.
 
 PNAME=patch-kernel
 

