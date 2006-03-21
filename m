Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWCUQfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCUQfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWCUQf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30732 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932436AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 25/46] kbuild: ignore all generated files for make allmodconfig (x86_64)
In-Reply-To: <11429580561641-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580561151-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With following patch we now ignore all generated files for
make allmodconfig for x86_64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 drivers/atm/.gitignore |    5 +++++
 sound/oss/.gitignore   |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)
 create mode 100644 drivers/atm/.gitignore
 create mode 100644 sound/oss/.gitignore

cc006288fb538005a14ca4297250abbf0beeb0b9
diff --git a/drivers/atm/.gitignore b/drivers/atm/.gitignore
new file mode 100644
index 0000000..a165b71
--- /dev/null
+++ b/drivers/atm/.gitignore
@@ -0,0 +1,5 @@
+# Ignore generated files
+fore200e_mkfirm
+fore200e_pca_fw.c
+pca200e.bin
+
diff --git a/sound/oss/.gitignore b/sound/oss/.gitignore
new file mode 100644
index 0000000..7efb12b
--- /dev/null
+++ b/sound/oss/.gitignore
@@ -0,0 +1,4 @@
+#Ignore generated files
+maui_boot.h
+pss_boot.h
+trix_boot.h
-- 
1.0.GIT


