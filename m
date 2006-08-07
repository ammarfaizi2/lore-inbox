Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWHGPIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWHGPIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWHGPIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:08:10 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33333 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932131AbWHGPII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:08:08 -0400
Date: Mon, 7 Aug 2006 17:08:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [patch] s390: hypfs comment cleanup.
Message-ID: <20060807150807.GG10416@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] hypfs comment cleanup.

Correct some comments in the hypervisor filesystem.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/hypfs.h      |    2 +-
 arch/s390/hypfs/hypfs_diag.c |    2 +-
 arch/s390/hypfs/hypfs_diag.h |    2 +-
 arch/s390/hypfs/inode.c      |    2 +-
 drivers/base/hypervisor.c    |    3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.c linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6/arch/s390/hypfs/hypfs_diag.c	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.c	2006-08-07 14:15:00.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  fs/hypfs/hypfs_diag.c
+ *  arch/s390/hypfs/hypfs_diag.c
  *    Hypervisor filesystem for Linux on s390. Diag 204 and 224
  *    implementation.
  *
diff -urpN linux-2.6/arch/s390/hypfs/hypfs_diag.h linux-2.6-patched/arch/s390/hypfs/hypfs_diag.h
--- linux-2.6/arch/s390/hypfs/hypfs_diag.h	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs_diag.h	2006-08-07 14:15:00.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  fs/hypfs/hypfs_diag.h
+ *  arch/s390/hypfs_diag.h
  *    Hypervisor filesystem for Linux on s390.
  *
  *    Copyright (C) IBM Corp. 2006
diff -urpN linux-2.6/arch/s390/hypfs/hypfs.h linux-2.6-patched/arch/s390/hypfs/hypfs.h
--- linux-2.6/arch/s390/hypfs/hypfs.h	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/hypfs.h	2006-08-07 14:15:00.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  fs/hypfs/hypfs.h
+ *  arch/s390/hypfs/hypfs.h
  *    Hypervisor filesystem for Linux on s390.
  *
  *    Copyright (C) IBM Corp. 2006
diff -urpN linux-2.6/arch/s390/hypfs/inode.c linux-2.6-patched/arch/s390/hypfs/inode.c
--- linux-2.6/arch/s390/hypfs/inode.c	2006-08-07 14:14:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/inode.c	2006-08-07 14:15:00.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *  fs/hypfs/inode.c
+ *  arch/s390/hypfs/inode.c
  *    Hypervisor filesystem for Linux on s390.
  *
  *    Copyright (C) IBM Corp. 2006
diff -urpN linux-2.6/drivers/base/hypervisor.c linux-2.6-patched/drivers/base/hypervisor.c
--- linux-2.6/drivers/base/hypervisor.c	2006-08-07 14:14:24.000000000 +0200
+++ linux-2.6-patched/drivers/base/hypervisor.c	2006-08-07 14:15:00.000000000 +0200
@@ -1,8 +1,9 @@
 /*
  * hypervisor.c - /sys/hypervisor subsystem.
  *
- * This file is released under the GPLv2
+ * Copyright (C) IBM Corp. 2006
  *
+ * This file is released under the GPLv2
  */
 
 #include <linux/kobject.h>
