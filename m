Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSJaXvD>; Thu, 31 Oct 2002 18:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265490AbSJaXvD>; Thu, 31 Oct 2002 18:51:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10368 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265480AbSJaXvB>;
	Thu, 31 Oct 2002 18:51:01 -0500
Date: Thu, 31 Oct 2002 16:57:19 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.45] Export blkdev_ioctl for raw block driver.
Message-ID: <20021031165719.A26498@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.857   -> 1.858  
#	      kernel/ksyms.c	1.155   -> 1.156  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/31	rem@doc.pdx.osdl.net	1.858
# Export blkdev_ioctl so that the raw device driver
# can be built as a module.
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Oct 31 16:47:14 2002
+++ b/kernel/ksyms.c	Thu Oct 31 16:47:14 2002
@@ -349,6 +349,7 @@
 EXPORT_SYMBOL(blkdev_open);
 EXPORT_SYMBOL(blkdev_get);
 EXPORT_SYMBOL(blkdev_put);
+EXPORT_SYMBOL(blkdev_ioctl);
 EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(init_buffer);

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
