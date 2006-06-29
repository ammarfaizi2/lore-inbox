Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933027AbWF2WE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbWF2WE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933024AbWF2WEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:04:10 -0400
Received: from mx.pathscale.com ([64.160.42.68]:29071 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932813AbWF2VoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:08 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 39] IB/ipath - update copyrights and other strings to
	reflect new company name
X-Mercurial-Node: f7c82500b9c76de42985f44f9fa755d9e0d908af
Message-Id: <f7c82500b9c76de42985.1151617253@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:53 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/Kconfig
--- a/drivers/infiniband/hw/ipath/Kconfig	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Kconfig	Thu Jun 29 14:33:25 2006 -0700
@@ -1,16 +1,16 @@ config IPATH_CORE
 config IPATH_CORE
-	tristate "PathScale InfiniPath Driver"
+	tristate "QLogic InfiniPath Driver"
 	depends on 64BIT && PCI_MSI && NET
 	---help---
-	This is a low-level driver for PathScale InfiniPath host channel
+	This is a low-level driver for QLogic InfiniPath host channel
 	adapters (HCAs) based on the HT-400 and PE-800 chips.
 
 config INFINIBAND_IPATH
-	tristate "PathScale InfiniPath Verbs Driver"
+	tristate "QLogic InfiniPath Verbs Driver"
 	depends on IPATH_CORE && INFINIBAND
 	---help---
 	This is a driver that provides InfiniBand verbs support for
-	PathScale InfiniPath host channel adapters (HCAs).  This
+	QLogic InfiniPath host channel adapters (HCAs).  This
 	allows these devices to be used with both kernel upper level
 	protocols such as IP-over-InfiniBand as well as with userspace
 	applications (in conjunction with InfiniBand userspace access).
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/Makefile
--- a/drivers/infiniband/hw/ipath/Makefile	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/Makefile	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,4 @@ EXTRA_CFLAGS += -DIPATH_IDSTR='"PathScal
-EXTRA_CFLAGS += -DIPATH_IDSTR='"PathScale kernel.org driver"' \
+EXTRA_CFLAGS += -DIPATH_IDSTR='"QLogic kernel.org driver"' \
 	-DIPATH_KERN_TYPE=0
 
 obj-$(CONFIG_IPATH_CORE) += ipath_core.o
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_common.h
--- a/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
@@ -38,7 +39,7 @@
  * to communicate between kernel and user code.
  */
 
-/* This is the IEEE-assigned OUI for PathScale, Inc. */
+/* This is the IEEE-assigned OUI for QLogic, Inc. InfiniPath */
 #define IPATH_SRC_OUI_1 0x00
 #define IPATH_SRC_OUI_2 0x11
 #define IPATH_SRC_OUI_3 0x75
@@ -342,9 +343,9 @@ struct ipath_base_info {
 /*
  * Similarly, this is the kernel version going back to the user.  It's
  * slightly different, in that we want to tell if the driver was built as
- * part of a PathScale release, or from the driver from OpenIB, kernel.org,
+ * part of a QLogic release, or from the driver from OpenIB, kernel.org,
  * or a standard distribution, for support reasons.  The high bit is 0 for
- * non-PathScale, and 1 for PathScale-built/supplied.
+ * non-QLogic, and 1 for QLogic-built/supplied.
  *
  * It's returned by the driver to the user code during initialization in the
  * spi_sw_version field of ipath_base_info, so the user code can in turn
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_cq.c
--- a/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_cq.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_debug.h
--- a/drivers/infiniband/hw/ipath/ipath_debug.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_diag.c
--- a/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_diag.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
@@ -52,7 +53,7 @@ const char *ipath_get_unit_name(int unit
 
 EXPORT_SYMBOL_GPL(ipath_get_unit_name);
 
-#define DRIVER_LOAD_MSG "PathScale " IPATH_DRV_NAME " loaded: "
+#define DRIVER_LOAD_MSG "QLogic " IPATH_DRV_NAME " loaded: "
 #define PFX IPATH_DRV_NAME ": "
 
 /*
@@ -74,8 +75,8 @@ EXPORT_SYMBOL_GPL(ipath_debug);
 EXPORT_SYMBOL_GPL(ipath_debug);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("PathScale <support@pathscale.com>");
-MODULE_DESCRIPTION("Pathscale InfiniPath driver");
+MODULE_AUTHOR("QLogic <support@pathscale.com>");
+MODULE_DESCRIPTION("QLogic InfiniPath driver");
 
 const char *ipath_ibcstatus_str[] = {
 	"Disabled",
@@ -452,7 +453,7 @@ static int __devinit ipath_init_one(stru
 		ipath_init_pe800_funcs(dd);
 		break;
 	default:
-		ipath_dev_err(dd, "Found unknown PathScale deviceid 0x%x, "
+		ipath_dev_err(dd, "Found unknown QLogic deviceid 0x%x, "
 			      "failing\n", ent->device);
 		return -ENODEV;
 	}
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_fs.c
--- a/drivers/infiniband/hw/ipath/ipath_fs.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_fs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_ht400.c
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,6 +1,7 @@
 #ifndef _IPATH_KERNEL_H
 #define _IPATH_KERNEL_H
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_keys.c
--- a/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_keys.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_layer.h
--- a/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_mad.c
--- a/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mad.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_mr.c
--- a/drivers/infiniband/hw/ipath/ipath_mr.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_mr.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
@@ -44,7 +45,7 @@
 
 /*
  * This file contains all the chip-specific register information and
- * access functions for the PathScale PE800, the PCI-Express chip.
+ * access functions for the QLogic InfiniPath PE800, the PCI-Express chip.
  *
  * This lists the InfiniPath PE800 registers, in the actual chip layout.
  * This structure should never be directly accessed.
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_ruc.c
--- a/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ruc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_srq.c
--- a/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_srq.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_stats.c
--- a/drivers/infiniband/hw/ipath/ipath_stats.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_stats.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_uc.c
--- a/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_uc.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_ud.c
--- a/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ud.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_user_pages.c
--- a/drivers/infiniband/hw/ipath/ipath_user_pages.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_user_pages.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
@@ -56,8 +57,8 @@ MODULE_PARM_DESC(debug, "Verbs debug mas
 MODULE_PARM_DESC(debug, "Verbs debug mask");
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("PathScale <support@pathscale.com>");
-MODULE_DESCRIPTION("Pathscale InfiniPath driver");
+MODULE_AUTHOR("QLogic <support@pathscale.com>");
+MODULE_DESCRIPTION("QLogic InfiniPath driver");
 
 const int ib_ipath_state_ops[IB_QPS_ERR + 1] = {
 	[IB_QPS_RESET] = 0,
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_verbs.h
--- a/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
--- a/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/ips_common.h
--- a/drivers/infiniband/hw/ipath/ips_common.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ips_common.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,6 +1,7 @@
 #ifndef IPS_COMMON_H
 #define IPS_COMMON_H
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
diff -r addf90abc724 -r f7c82500b9c7 drivers/infiniband/hw/ipath/verbs_debug.h
--- a/drivers/infiniband/hw/ipath/verbs_debug.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/verbs_debug.h	Thu Jun 29 14:33:25 2006 -0700
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2006 QLogic, Inc. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
