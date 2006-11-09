Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932812AbWKILax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbWKILax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 06:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWKILax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 06:30:53 -0500
Received: from il.qumranet.com ([62.219.232.206]:19091 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932812AbWKILaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 06:30:52 -0500
Subject: [PATCH] KVM: Include desc.h
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 09 Nov 2006 11:30:51 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20061109113051.7631E2500F8@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Kagstrom <simon.kagstrom@bth.se>

This fixes compilation on some (32-bit) .configs.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
+#include <asm/desc.h>
 
 #include "vmx.h"
 #include "x86_emulate.h"
