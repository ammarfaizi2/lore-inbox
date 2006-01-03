Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWACN0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWACN0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWACNZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:47109 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932365AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 19/26] kbuild: remove EXPERIMENTAL tag from Module versioning
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <1136294726848@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1135634642 +0100

Module versioning support has been stable for a loong time
so let's get rid of the EXPERIMENTAL tag.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 init/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

0d5416433190ee80a8146137dd84613bb9c7ae92
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
-- 
1.0.6

