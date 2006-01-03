Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWACN0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWACN0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWACNZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:56 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44037 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932363AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 26/26] gitignore: ignore more generated files
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947263487@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 kernel/.gitignore                   |    5 +++++
 scripts/.gitignore                  |    5 ++++-
 scripts/kconfig/lxdialog/.gitignore |    4 ++++
 3 files changed, 13 insertions(+), 1 deletions(-)
 create mode 100644 kernel/.gitignore
 create mode 100644 scripts/kconfig/lxdialog/.gitignore

febf7ea4bedcd36fba0843db726bba28d22bf89a
diff --git a/kernel/.gitignore b/kernel/.gitignore
new file mode 100644
index 0000000..f2ab700
--- /dev/null
+++ b/kernel/.gitignore
@@ -0,0 +1,5 @@
+#
+# Generated files
+#
+config_data.h
+config_data.gz
diff --git a/scripts/.gitignore b/scripts/.gitignore
index b46d68b..a234e52 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,4 +1,7 @@
+#
+# Generated files
+#
 conmakehash
 kallsyms
 pnmtologo
-
+bin2c
diff --git a/scripts/kconfig/lxdialog/.gitignore b/scripts/kconfig/lxdialog/.gitignore
new file mode 100644
index 0000000..90b08ff
--- /dev/null
+++ b/scripts/kconfig/lxdialog/.gitignore
@@ -0,0 +1,4 @@
+#
+# Generated files
+#
+lxdialog
-- 
1.0.6

