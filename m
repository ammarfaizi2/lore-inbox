Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTH1WNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTH1WNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:13:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:35737 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264410AbTH1WKF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:10:05 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10621085961601@kroah.com>
Subject: [PATCH] PCI Hotplug patches for 2.4.23-pre1
In-Reply-To: <20030828220711.GA13344@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 28 Aug 2003 15:09:56 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       marcelo@conectiva.com.br
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.3, 2003/08/28 11:23:37-07:00, greg@kroah.com

[PATCH] PCI hotplug: fix up a bunch of copyrights that were incorrectly declared.

It needs to be "Copyright (C)" not "Copyright (c)" according to the lawyers
who know these things...


 drivers/hotplug/acpiphp.h          |   12 ++++++------
 drivers/hotplug/acpiphp_core.c     |   12 ++++++------
 drivers/hotplug/acpiphp_glue.c     |    6 +++---
 drivers/hotplug/acpiphp_pci.c      |   12 ++++++------
 drivers/hotplug/acpiphp_res.c      |   12 ++++++------
 drivers/hotplug/cpqphp.h           |    6 +++---
 drivers/hotplug/cpqphp_core.c      |    6 +++---
 drivers/hotplug/cpqphp_ctrl.c      |    6 +++---
 drivers/hotplug/cpqphp_nvram.c     |    6 +++---
 drivers/hotplug/cpqphp_nvram.h     |    4 ++--
 drivers/hotplug/cpqphp_pci.c       |    6 +++---
 drivers/hotplug/cpqphp_proc.c      |    6 +++---
 drivers/hotplug/ibmphp.h           |    4 ++--
 drivers/hotplug/ibmphp_core.c      |    4 ++--
 drivers/hotplug/ibmphp_ebda.c      |    4 ++--
 drivers/hotplug/ibmphp_hpc.c       |    2 +-
 drivers/hotplug/ibmphp_pci.c       |    4 ++--
 drivers/hotplug/ibmphp_res.c       |    4 ++--
 drivers/hotplug/pci_hotplug.h      |    6 +++---
 drivers/hotplug/pci_hotplug_core.c |    4 ++--
 drivers/hotplug/pci_hotplug_util.c |    6 +++---
 21 files changed, 66 insertions(+), 66 deletions(-)


diff -Nru a/drivers/hotplug/acpiphp.h b/drivers/hotplug/acpiphp.h
--- a/drivers/hotplug/acpiphp.h	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/acpiphp.h	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/acpiphp_core.c b/drivers/hotplug/acpiphp_core.c
--- a/drivers/hotplug/acpiphp_core.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/acpiphp_core.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/acpiphp_glue.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/acpiphp_pci.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/acpiphp_res.c b/drivers/hotplug/acpiphp_res.c
--- a/drivers/hotplug/acpiphp_res.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/acpiphp_res.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp.h	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_core.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_ctrl.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_nvram.c b/drivers/hotplug/cpqphp_nvram.c
--- a/drivers/hotplug/cpqphp_nvram.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_nvram.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_nvram.h b/drivers/hotplug/cpqphp_nvram.h
--- a/drivers/hotplug/cpqphp_nvram.h	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_nvram.h	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/cpqphp_proc.c b/drivers/hotplug/cpqphp_proc.c
--- a/drivers/hotplug/cpqphp_proc.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/cpqphp_proc.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/ibmphp.h b/drivers/hotplug/ibmphp.h
--- a/drivers/hotplug/ibmphp.h	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp.h	Thu Aug 28 15:02:32 2003
@@ -6,8 +6,8 @@
  *
  * Written By: Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp_core.c	Thu Aug 28 15:02:32 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Chuck Cole, Jyoti Shah, Tong Yu, Irene Zubarev, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp_ebda.c	Thu Aug 28 15:02:32 2003
@@ -3,8 +3,8 @@
  *
  * Written By: Tong Yu, IBM Corporation
  *
- * Copyright (c) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (c) 2001,2002 IBM Corp.
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001,2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/hotplug/ibmphp_hpc.c b/drivers/hotplug/ibmphp_hpc.c
--- a/drivers/hotplug/ibmphp_hpc.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp_hpc.c	Thu Aug 28 15:02:32 2003
@@ -3,7 +3,7 @@
  *
  * Written By: Jyoti Shah, IBM Corporation
  *
- * Copyright (c) 2001-2002 IBM Corp.
+ * Copyright (C) 2001-2002 IBM Corp.
  *
  * All rights reserved.
  *
diff -Nru a/drivers/hotplug/ibmphp_pci.c b/drivers/hotplug/ibmphp_pci.c
--- a/drivers/hotplug/ibmphp_pci.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp_pci.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/ibmphp_res.c b/drivers/hotplug/ibmphp_res.c
--- a/drivers/hotplug/ibmphp_res.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/ibmphp_res.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/pci_hotplug.h	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Aug 28 15:02:32 2003
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
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Thu Aug 28 15:02:32 2003
+++ b/drivers/hotplug/pci_hotplug_util.c	Thu Aug 28 15:02:32 2003
@@ -1,9 +1,9 @@
 /*
  * PCI HotPlug Utility functions
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

