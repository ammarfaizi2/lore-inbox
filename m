Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWBWSuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWBWSuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBWSuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:50:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751254AbWBWSuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:50:03 -0500
Date: Thu, 23 Feb 2006 13:49:50 -0500
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: s/Overwrite/Override/ in arch/x86-64
Message-ID: <20060223184950.GA26499@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/Overwrite/Override/

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/arch/x86_64/kernel/io_apic.c~	2006-02-23 13:47:39.000000000 -0500
+++ linux-2.6.15.noarch/arch/x86_64/kernel/io_apic.c	2006-02-23 13:47:51.000000000 -0500
@@ -294,7 +294,7 @@ void __init check_ioapic(void) 
 					     force_iommu) &&
 					    !iommu_aperture_allowed) {
 						printk(KERN_INFO
-    "Looks like a VIA chipset. Disabling IOMMU. Overwrite with \"iommu=allowed\"\n");
+    "Looks like a VIA chipset. Disabling IOMMU. Override with \"iommu=allowed\"\n");
 						iommu_aperture_disabled = 1;
 					}
 #endif
--- linux-2.6.15.noarch/arch/x86_64/ia32/ia32_binfmt.c~	2006-02-23 13:48:08.000000000 -0500
+++ linux-2.6.15.noarch/arch/x86_64/ia32/ia32_binfmt.c	2006-02-23 13:48:17.000000000 -0500
@@ -58,7 +58,7 @@ struct elf_phdr; 
 
 #define USE_ELF_CORE_DUMP 1
 
-/* Overwrite elfcore.h */ 
+/* Override elfcore.h */ 
 #define _LINUX_ELFCORE_H 1
 typedef unsigned int elf_greg_t;
 
