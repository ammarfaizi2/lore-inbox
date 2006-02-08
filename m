Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWBHDY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWBHDY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbWBHDT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:129 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1030477AbWBHDTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:22 -0500
To: torvalds@osdl.org
Subject: [PATCH 18/29] drivers/edac/i82875p_edac.c __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6frW-0006DM-3d@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138792208 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/edac/i82875p_edac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6d57348d7d65ba6f2f42a24b0c7527e0f7470a84
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 009c08f..1991f94 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -159,7 +159,7 @@ enum i82875p_chips {
 
 struct i82875p_pvt {
 	struct pci_dev *ovrfl_pdev;
-	void *ovrfl_window;
+	void __iomem *ovrfl_window;
 };
 
 
-- 
0.99.9.GIT

