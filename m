Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757453AbWK0It1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbWK0It1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbWK0It0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:49:26 -0500
Received: from il.qumranet.com ([62.219.232.206]:58061 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1757453AbWK0It0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:49:26 -0500
Subject: [PATCH 2/2] KVM: Make enum values in userspace interface explicit
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 08:49:24 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AA620.4000201@qumranet.com>
In-Reply-To: <456AA620.4000201@qumranet.com>
Message-Id: <20061127084924.D0A7125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

--- linux-2.6/include/linux/kvm.h	2006-11-27 10:31:40.000000000 +0200
+++ linux-2.6/include/linux/kvm.h	2006-11-19 12:25:35.000000000 +0200
@@ -36,13 +36,13 @@
 #define KVM_EXIT_TYPE_VM_EXIT    2
 
 enum kvm_exit_reason {
-	KVM_EXIT_UNKNOWN,
-	KVM_EXIT_EXCEPTION,
-	KVM_EXIT_IO,
-	KVM_EXIT_CPUID,
-	KVM_EXIT_DEBUG,
-	KVM_EXIT_HLT,
-	KVM_EXIT_MMIO,
+	KVM_EXIT_UNKNOWN          = 0,
+	KVM_EXIT_EXCEPTION        = 1,
+	KVM_EXIT_IO               = 2,
+	KVM_EXIT_CPUID            = 3,
+	KVM_EXIT_DEBUG            = 4,
+	KVM_EXIT_HLT              = 5,
+	KVM_EXIT_MMIO             = 6,
 };
 
 /* for KVM_RUN */
