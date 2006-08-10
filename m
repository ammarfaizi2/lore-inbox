Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWHJUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWHJUPF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHJUPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:31467 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932373AbWHJTgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:06 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [45/145] x86_64: Add some comments what tce.c actually does
Message-Id: <20060810193559.9B42113B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:59 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/tce.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/kernel/tce.c
===================================================================
--- linux.orig/arch/x86_64/kernel/tce.c
+++ linux/arch/x86_64/kernel/tce.c
@@ -1,4 +1,6 @@
 /*
+ * This file manages the translation entries for the IBM Calgary IOMMU.
+ *
  * Derived from arch/powerpc/platforms/pseries/iommu.c
  *
  * Copyright (C) IBM Corporation, 2006
