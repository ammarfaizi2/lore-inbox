Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSEDOhs>; Sat, 4 May 2002 10:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313132AbSEDOhs>; Sat, 4 May 2002 10:37:48 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:46098 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S313122AbSEDOhq>;
	Sat, 4 May 2002 10:37:46 -0400
Date: Sat, 4 May 2002 16:37:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 2)
Message-ID: <20020504163745.A11116@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am sending the following patch to Marcelo for inclusion in the kernel.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.406   -> 1.407  
#	 drivers/pci/pci.ids	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/04	wim@iguana.be	1.407
# [PATCH] 2.4.19-pre8 - i8xx series chipsets patches (patch 2)
# 
# Add 82801E I/O Controller Hub PCI-IDS to pci.ids file.
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Sat May  4 15:14:19 2002
+++ b/drivers/pci/pci.ids	Sat May  4 15:14:19 2002
@@ -5805,6 +5805,13 @@
 	244b  82801BA IDE U100
 	244c  82801BAM ISA Bridge (LPC)
 	244e  82801BA/CA PCI Bridge
+	2450  82801E ISA Bridge (LPC)
+	2452  82801E USB
+	2453  82801E SMBus
+	2459  82801E Ethernet Controller 0
+	245b  82801E IDE U100
+	245d  82801E Ethernet Controller 1
+	245e  82801E PCI Bridge
 	2480  82801CA ISA Bridge (LPC)
 	2482  82801CA/CAM USB (Hub #1)
 	2483  82801CA/CAM SMBus
