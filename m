Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSFETrE>; Wed, 5 Jun 2002 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFETrD>; Wed, 5 Jun 2002 15:47:03 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:776 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S316043AbSFETrC>;
	Wed, 5 Jun 2002 15:47:02 -0400
Date: Wed, 5 Jun 2002 21:46:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19-pre10 - i8xx series chipsets patches (patch 6)
Message-ID: <20020605214645.A19001@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

My last patch contained a typo. This patch fixes this.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.542   -> 1.543  
#	arch/i386/kernel/pci-irq.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/05	wim@iguana.be	1.543
# [PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 6)
# 
# Fixed typo in my previous patch.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/pci-irq.c b/arch/i386/kernel/pci-irq.c
--- a/arch/i386/kernel/pci-irq.c	Wed Jun  5 21:41:29 2002
+++ b/arch/i386/kernel/pci-irq.c	Wed Jun  5 21:41:29 2002
@@ -467,7 +467,7 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_10, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
-	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_O, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
