Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWHGU7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWHGU7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWHGU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:59:00 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:27544 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932381AbWHGU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:59:00 -0400
Date: Mon, 7 Aug 2006 14:00:30 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial: Consolidate HPET_TIMER Makefile entries
Message-ID: <20060807210030.GA1391@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Deepak Saxena <dsaxena@mvista.com>


diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index ab98fc2..085b9fa 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -32,12 +32,11 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
-obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
