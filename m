Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWBHHOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWBHHOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBHHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:14:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53149 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161058AbWBHHLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:11:21 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] mark HISAX_AMD7930 as broken
Message-Id: <E1F6jU1-0002ga-2y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:11:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138794337 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/isdn/hisax/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

90f46a5845596f0bf99f3a07dd4c7775dcbb40c4
diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index 0ef5601..6dfc941 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -351,7 +351,7 @@ config HISAX_ENTERNOW_PCI
 
 config HISAX_AMD7930
 	bool "Am7930 (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && SPARC
+	depends on EXPERIMENTAL && SPARC && BROKEN
 	help
 	  This enables HiSax support for the AMD7930 chips on some SPARCs.
 	  This code is not finished yet.
-- 
0.99.9.GIT

