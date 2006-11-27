Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758153AbWK0Msl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbWK0Msl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758157AbWK0Msl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:48:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:35203 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758153AbWK0Msk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:48:40 -0500
Subject: [PATCH 38/38] KVM: Remove vmx includes from arch independent code
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:48:39 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124839.2377425015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -35,8 +35,6 @@
 #include <linux/file.h>
 #include <asm/desc.h>
 
-#include "vmx.h"
-#include "kvm_vmx.h"
 #include "x86_emulate.h"
 
 MODULE_AUTHOR("Qumranet");
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -16,9 +16,9 @@
  */
 
 #include "kvm.h"
-#include <linux/module.h>
 #include "vmx.h"
 #include "kvm_vmx.h"
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <asm/io.h>
