Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVLZWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLZWbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVLZWbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:31:06 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:65407 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751086AbVLZWbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:31:04 -0500
Date: Mon, 26 Dec 2005 23:00:28 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Remove EXPERIMENTAL for module versioning
Message-ID: <20051226220028.GA31328@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module versioning has since early 2.5 been marked EXPERIMENTAL.
But except for one recent bug fixed already fixed by Robin Holt
I have had no mails about this feature for a long time.
So it is to be considered a stable feature and it will have the
EXPERIMENTAL mark removed.

Let me know if you disagree.

	Sam

diff --git a/init/Kconfig b/init/Kconfig
index ea097e0..11930fb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -460,8 +460,8 @@ config OBSOLETE_MODPARM
 	  If unsure, say Y.
 
 config MODVERSIONS
-	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL
+	bool "Module versioning support"
+	depends on MODULES
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
