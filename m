Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757464AbWK0Is1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbWK0Is1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbWK0Is1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:48:27 -0500
Received: from il.qumranet.com ([62.219.232.206]:57037 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1757459AbWK0Is0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:48:26 -0500
Subject: [PATCH 1/2] KVM: Clarify licensing
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 08:48:24 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AA620.4000201@qumranet.com>
In-Reply-To: <456AA620.4000201@qumranet.com>
Message-Id: <20061127084824.C0BD225015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm.h /home/avi/kvm-release/kernel/kvm.h
--- linux-2.6/drivers/kvm/kvm.h	2006-11-27 10:31:16.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm.h	2006-11-15 18:51:06.000000000 +0200
@@ -1,6 +1,11 @@
 #ifndef __KVM_H
 #define __KVM_H
 
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm_main.c /home/avi/kvm-release/kernel/kvm_main.c
--- linux-2.6/drivers/kvm/kvm_main.c	2006-11-27 10:31:16.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm_main.c	2006-11-20 11:17:55.000000000 +0200
@@ -10,6 +10,9 @@
  *   Avi Kivity   <avi@qumranet.com>
  *   Yaniv Kamay  <yaniv@qumranet.com>
  *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
  */
 
 #include "kvm.h"
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/mmu.c /home/avi/kvm-release/kernel/mmu.c
--- linux-2.6/drivers/kvm/mmu.c	2006-11-27 10:31:16.000000000 +0200
+++ linux-2.6/drivers/kvm/mmu.c	2006-11-08 10:41:04.000000000 +0200
@@ -12,6 +12,9 @@
  *   Yaniv Kamay  <yaniv@qumranet.com>
  *   Avi Kivity   <avi@qumranet.com>
  *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
  */
 #include <linux/types.h>
 #include <linux/string.h>
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/paging_tmpl.h /home/avi/kvm-release/kernel/paging_tmpl.h
--- linux-2.6/drivers/kvm/paging_tmpl.h	2006-11-27 10:31:16.000000000 +0200
+++ linux-2.6/drivers/kvm/paging_tmpl.h	2006-11-08 10:41:04.000000000 +0200
@@ -1,4 +1,23 @@
 /*
+ * Kernel-based Virtual Machine driver for Linux
+ *
+ * This module enables machines with Intel VT-x extensions to run virtual
+ * machines without emulation or binary translation.
+ *
+ * MMU support
+ *
+ * Copyright (C) 2006 Qumranet, Inc.
+ *
+ * Authors:
+ *   Yaniv Kamay  <yaniv@qumranet.com>
+ *   Avi Kivity   <avi@qumranet.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+/*
  * We need the mmu code to access both 32-bit and 64-bit guest ptes,
  * so the code in this file is compiled twice, once per pte size.
  */
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/x86_emulate.c /home/avi/kvm-release/kernel/x86_emulate.c
--- linux-2.6/drivers/kvm/x86_emulate.c	2006-11-27 10:31:16.000000000 +0200
+++ linux-2.6/drivers/kvm/x86_emulate.c	2006-11-20 11:39:59.000000000 +0200
@@ -13,6 +13,9 @@
  *   Avi Kivity <avi@qumranet.com>
  *   Yaniv Kamay <yaniv@qumranet.com>
  *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
  * From: xen-unstable 10676:af9809f51f81a3c43f276f00c81a52ef558afda4
  */
 
