Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422946AbWHZAEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422946AbWHZAEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422937AbWHZADI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:03:08 -0400
Received: from mga06.intel.com ([134.134.136.21]:59488 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422930AbWHZADG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:06 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="115152394:sNHT16656332"
Message-Id: <20060826000302.959538000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:30 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thibaut Varene <varenet@parisc-linux.org>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Valerie Henson <val_henson@linux.intel.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: [patch 03/10] [TULIP] Make DS21143 printout match lspci output
Content-Disposition: inline; filename=tulip-make-ds21143-printout-match-lspci-output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thibaut Varene <varenet@parisc-linux.org>

Signed-off-by: Thibaut Varene <varenet@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
Signed-off-by: Valerie Henson <val_henson@linux.intel.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

---
 drivers/net/tulip/tulip_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/tulip_core.c
+++ linux-2.6.18-rc4-mm1/drivers/net/tulip/tulip_core.c
@@ -147,7 +147,7 @@ struct tulip_chip_table tulip_tbl[] = {
 	HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer },
 
   /* DC21142, DC21143 */
-  { "Digital DS21143 Tulip", 128, 0x0801fbff,
+  { "Digital DS21142/43 Tulip", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | HAS_NWAY
 	| HAS_INTR_MITIGATION | HAS_PCI_MWI, t21142_timer },
 

--
