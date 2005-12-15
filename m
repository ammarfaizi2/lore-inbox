Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbVLOJTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbVLOJTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbVLOJTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63107 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422651AbVLOJTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:19:05 -0500
To: torvalds@osdl.org
Subject: [PATCH] drivers/input/misc/wistron_btns.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpGT-00080y-4c@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:19:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/input/misc/wistron_btns.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8416bbf668b31d027cda6995d3aa3eabbe507f05
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 49d0416..bac3085 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -320,7 +320,7 @@ static struct dmi_system_id dmi_ids[] = 
 		},
 		.driver_data = keymap_acer_aspire_1500
 	},
-	{ 0, }
+	{ NULL, }
 };
 
 static int __init select_keymap(void)
-- 
0.99.9.GIT

