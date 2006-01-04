Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWADWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWADWGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWADWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:06:09 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:48115 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030371AbWADWAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:00:22 -0500
Date: Wed, 04 Jan 2006 16:59:59 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 05/15] pci: Add Toshiba PSA40U laptop to ohci1394 quirk dmi
 table.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00NV994G1L@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 arch/i386/pci/fixup.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

ab501219717d15686ad4ab488e070cce8c42b24c
diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index eeb1b1f..65f6707 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -413,6 +413,13 @@ static struct dmi_system_id __devinitdat
 			DMI_MATCH(DMI_PRODUCT_VERSION, "PSM4"),
 		},
 	},
+	{
+		.ident = "Toshiba A40 based laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "PSA40U"),
+		},
+	},
 	{ }
 };
 
-- 
1.0.5
