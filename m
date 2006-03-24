Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423174AbWCXGMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423174AbWCXGMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423173AbWCXGMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:37594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161012AbWCXGLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:45 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/12] aoe [4/8]: use less confusing driver name
In-Reply-To: <11431806532147-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <11431806533029-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Users were confused by the driver being called "aoe-2.6-$version".
This form looks less like a Linux kernel version number.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoemain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

c42b24cae5c9fe1ae1f9bb9dea020e1a788fab4d
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 387588a..f39d5ba 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -89,7 +89,7 @@ aoe_init(void)
 	}
 
 	printk(KERN_INFO
-	       "aoe: aoe_init: AoE v2.6-%s initialised.\n",
+	       "aoe: aoe_init: AoE v%s initialised.\n",
 	       VERSION);
 	discover_timer(TINIT);
 	return 0;
-- 
1.2.4


