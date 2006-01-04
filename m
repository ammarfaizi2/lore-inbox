Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWADWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWADWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWADWBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:01:24 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:53749 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932281AbWADWBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:22 -0500
Date: Wed, 04 Jan 2006 17:01:00 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 10/15] i8042: Add OQO Zepto to noloop dmi table.
To: linux-kernel@vger.kernel.org
Message-id: <0ISL00EMM9646A@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

9004ea5383b027173d73dd73155269068d78d958
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 273bb3b..2917f9e 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -84,6 +84,14 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
 		},
 	},
+	{
+		.ident = "OQO Model 01",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
+		},
+	},
 	{ }
 };
 
-- 
1.0.5
