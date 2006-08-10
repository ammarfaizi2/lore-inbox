Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWHJTtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWHJTtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHJTrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:47:42 -0400
Received: from mx1.suse.de ([195.135.220.2]:30353 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932679AbWHJThZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:25 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [125/145] i376: Make acpi_force static
Message-Id: <20060810193724.A2B5F13C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:24 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Adrian Bunk <bunk@stusta.de>

acpi_force can become static.

Cc: len.brown@intel.com

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/acpi/boot.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -36,7 +36,7 @@
 #include <asm/io.h>
 #include <asm/mpspec.h>
 
-int __initdata acpi_force = 0;
+static int __initdata acpi_force = 0;
 
 #ifdef	CONFIG_ACPI
 int acpi_disabled = 0;
