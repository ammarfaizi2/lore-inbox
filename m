Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTIKW7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTIKW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:59:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:50578 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261582AbTIKW6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:58:49 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10633211522265@kroah.com>
Subject: [PATCH] PCI fixes for 2.6.0-test5
In-Reply-To: <20030911225418.GA14551@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 11 Sep 2003 15:59:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.78.1, 2003/08/27 14:45:27-07:00, greg@kroah.com

[PATCH] PCI hotplug: fix up a bunch of copyrights that were incorrectly declared.

It needs to be "Copyright (C)" not "Copyright (c)" according to the lawyers
who know these things...


 drivers/pci/hotplug/acpiphp.h           |   12 ++++++------
 drivers/pci/hotplug/acpiphp_core.c      |   12 ++++++------
 drivers/pci/hotplug/acpiphp_glue.c      |    6 +++---
 drivers/pci/hotplug/acpiphp_pci.c       |   12 ++++++------
 drivers/pci/hotplug/acpiphp_res.c       |   12 ++++++------
 drivers/pci/hotplug/cpci_hotplug.h      |    6 +++---
 drivers/pci/hotplug/cpci_hotplug_core.c |    6 +++---
 drivers/pci/hotplug/cpci_hotplug_pci.c  |    2 +-
 drivers/pci/hotplug/cpqphp.h            |    6 +++---
 drivers/pci/hotplug/cpqphp_core.c       |    6 +++---
 drivers/pci/hotplug/cpqphp_ctrl.c       |    6 +++---
 drivers/pci/hotplug/cpqphp_nvram.c      |    6 +++---
 drivers/pci/hotplug/cpqphp_nvram.h      |    4 ++--
 drivers/pci/hotplug/cpqphp_pci.c        |    6 +++---
 drivers/pci/hotplug/cpqphp_sysfs.c      |    6 +++---
 drivers/pci/hotplug/fakephp.c           |    6 +++---
 drivers/pci/hotplug/ibmphp.h            |    4 ++--
 drivers/pci/hotplug/ibmphp_core.c       |    4 ++--
 drivers/pci/hotplug/ibmphp_ebda.c       |    4 ++--
 drivers/pci/hotplug/ibmphp_hpc.c        |    2 +-
 drivers/pci/hotplug/ibmphp_pci.c        |    4 ++--
 drivers/pci/hotplug/ibmphp_res.c        |    4 ++--
 drivers/pci/hotplug/pci_hotplug.h       |    6 +++---
 drivers/pci/hotplug/pci_hotplug_core.c  |    4 ++--
 drivers/pci/hotplug/pcihp_skeleton.c    |    4 ++--
 25 files changed, 75 insertions(+), 75 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
--- a/drivers/pci/hotplug/acpiphp.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/acpiphp.h	Thu Sep 11 15:54:58 2003
@@ -1,12 +1,12 @@
 /*
  * ACPI PCI Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
- * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (c) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (c) 2002,2003 NEC Corporation
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
+ * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
+ * Copyright (C) 2002,2003 NEC Corporation
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/acpiphp_core.c	Thu Sep 11 15:54:58 2003
@@ -1,12 +1,12 @@
 /*
  * ACPI PCI Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
- * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (c) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (c) 2002,2003 NEC Corporation
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
+ * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
+ * Copyright (C) 2002,2003 NEC Corporation
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * ACPI PCI HotPlug glue functions to ACPI CA subsystem
  *
- * Copyright (c) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (c) 2002,2003 NEC Corporation
+ * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
+ * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (C) 2002,2003 NEC Corporation
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Thu Sep 11 15:54:58 2003
@@ -1,12 +1,12 @@
 /*
  * ACPI PCI HotPlug PCI configuration space management
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
- * Copyright (c) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (c) 2002 NEC Corporation
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
+ * Copyright (C) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
+ * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (C) 2002 NEC Corporation
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/acpiphp_res.c b/drivers/pci/hotplug/acpiphp_res.c
--- a/drivers/pci/hotplug/acpiphp_res.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/acpiphp_res.c	Thu Sep 11 15:54:58 2003
@@ -1,12 +1,12 @@
 /*
  * ACPI PCI HotPlug Utility functions
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
- * Copyright (c) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
- * Copyright (c) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
- * Copyright (c) 2002 NEC Corporation
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
+ * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
+ * Copyright (C) 2002 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
+ * Copyright (C) 2002 NEC Corporation
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
--- a/drivers/pci/hotplug/cpci_hotplug.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpci_hotplug.h	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * CompactPCI Hot Plug Core Functions
  *
- * Copyright (c) 2002 SOMA Networks, Inc.
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 2002 SOMA Networks, Inc.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * CompactPCI Hot Plug Driver
  *
- * Copyright (c) 2002 SOMA Networks, Inc.
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 2002 SOMA Networks, Inc.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c	Thu Sep 11 15:54:58 2003
@@ -1,7 +1,7 @@
 /*
  * CompactPCI Hot Plug Driver PCI functions
  *
- * Copyright (c) 2002 by SOMA Networks, Inc.
+ * Copyright (C) 2002 by SOMA Networks, Inc.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
--- a/drivers/pci/hotplug/cpqphp.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp.h	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_core.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
--- a/drivers/pci/hotplug/cpqphp_ctrl.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_nvram.c b/drivers/pci/hotplug/cpqphp_nvram.c
--- a/drivers/pci/hotplug/cpqphp_nvram.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_nvram.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_nvram.h b/drivers/pci/hotplug/cpqphp_nvram.h
--- a/drivers/pci/hotplug/cpqphp_nvram.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_nvram.h	Thu Sep 11 15:54:58 2003
@@ -1,8 +1,8 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/cpqphp_sysfs.c b/drivers/pci/hotplug/cpqphp_sysfs.c
--- a/drivers/pci/hotplug/cpqphp_sysfs.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/cpqphp_sysfs.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Compaq Hot Plug Controller Driver
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
--- a/drivers/pci/hotplug/fakephp.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/fakephp.c	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * Fake PCI Hot Plug Controller Driver
  *
- * Copyright (c) 2003 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (c) 2003 IBM Corp.
- * Copyright (c) 2003 Rolf Eike Beer <eike-kernel@sf-tec.de>
+ * Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2003 IBM Corp.
+ * Copyright (C) 2003 Rolf Eike Beer <eike-kernel@sf-tec.de>
  *
  * Based on ideas and code from:
  * 	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
diff -Nru a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
--- a/drivers/pci/hotplug/ibmphp.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp.h	Thu Sep 11 15:54:58 2003
@@ -6,8 +6,8 @@
  *
  * Written By: Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001-2003 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp_core.c	Thu Sep 11 15:54:58 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Chuck Cole, Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001-2003 IBM Corp.
+ * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	Thu Sep 11 15:54:58 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Tong Yu, IBM Corporation
  *
- * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001-2003 IBM Corp.
+ * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	Thu Sep 11 15:54:58 2003
@@ -3,7 +3,7 @@
  *
  * Written By: Jyoti Shah, IBM Corporation
  *
- * Copyright (c) 2001-2003 IBM Corp.
+ * Copyright (C) 2001-2003 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp_pci.c	Thu Sep 11 15:54:58 2003
@@ -3,8 +3,8 @@
  * 
  * Written By: Irene Zubarev, IBM Corporation
  * 
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
--- a/drivers/pci/hotplug/ibmphp_res.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/ibmphp_res.c	Thu Sep 11 15:54:58 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/pci_hotplug.h	Thu Sep 11 15:54:58 2003
@@ -1,9 +1,9 @@
 /*
  * PCI HotPlug Core Functions
  *
- * Copyright (c) 1995,2001 Compaq Computer Corporation
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001 IBM Corp.
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Thu Sep 11 15:54:58 2003
@@ -1,8 +1,8 @@
 /*
  * PCI HotPlug Controller Core
  *
- * Copyright (c) 2001-2002 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001-2002 IBM Corp.
+ * Copyright (C) 2001-2002 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001-2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/pci/hotplug/pcihp_skeleton.c b/drivers/pci/hotplug/pcihp_skeleton.c
--- a/drivers/pci/hotplug/pcihp_skeleton.c	Thu Sep 11 15:54:58 2003
+++ b/drivers/pci/hotplug/pcihp_skeleton.c	Thu Sep 11 15:54:58 2003
@@ -1,8 +1,8 @@
 /*
  * PCI Hot Plug Controller Skeleton Driver - 0.2
  *
- * Copyright (c) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2003 IBM Corp.
+ * Copyright (C) 2001,2003 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2003 IBM Corp.
  *
  * All rights reserved.
  *

