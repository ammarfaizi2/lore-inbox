Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965313AbVKBW3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbVKBW3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbVKBW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:29:29 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:59298 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965313AbVKBW33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:29:29 -0500
Date: Thu, 3 Nov 2005 00:29:25 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] sh: Re-add sh to drivers/Makefile.
Message-ID: <20051102222925.GA27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/sh/ got dropped from drivers/Makefile, so add it back in..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: b87f06d928e0ea06ae6244c1aeecf3e745f39bb9
ba95fbff2ea16e371001052759317163b6dbcd5c
diff --git a/drivers/Makefile b/drivers/Makefile
index 65670be..61c64f7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_SUPERH)		+= sh/
---
0.99.8.GIT
