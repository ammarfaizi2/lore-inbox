Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWACN1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWACN1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWACNZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:52 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43013 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932367AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 24/26] gitignore: misc files
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947262881@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <bgerst@didntduck.org>
Date: 1135745011 -0500

Ignore all files generated from *_shipped files, plus a few others.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 drivers/char/.gitignore         |    2 +-
 drivers/ieee1394/.gitignore     |    1 +
 drivers/md/.gitignore           |    4 ++++
 drivers/net/wan/.gitignore      |    1 +
 drivers/scsi/.gitignore         |    3 +++
 drivers/scsi/aic7xxx/.gitignore |    6 ++++++
 scripts/genksyms/.gitignore     |    4 ++++
 scripts/kconfig/.gitignore      |    1 +
 8 files changed, 21 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ieee1394/.gitignore
 create mode 100644 drivers/md/.gitignore
 create mode 100644 drivers/net/wan/.gitignore
 create mode 100644 drivers/scsi/.gitignore
 create mode 100644 drivers/scsi/aic7xxx/.gitignore
 create mode 100644 scripts/genksyms/.gitignore

352dd1df32e672be4cff71132eb9c06a257872fe
diff --git a/drivers/char/.gitignore b/drivers/char/.gitignore
index 2b6b1d7..73dfdce 100644
--- a/drivers/char/.gitignore
+++ b/drivers/char/.gitignore
@@ -1,3 +1,3 @@
 consolemap_deftbl.c
 defkeymap.c
-
+qtronixmap.c
diff --git a/drivers/ieee1394/.gitignore b/drivers/ieee1394/.gitignore
new file mode 100644
index 0000000..33da10a
--- /dev/null
+++ b/drivers/ieee1394/.gitignore
@@ -0,0 +1 @@
+oui.c
diff --git a/drivers/md/.gitignore b/drivers/md/.gitignore
new file mode 100644
index 0000000..a7afec6
--- /dev/null
+++ b/drivers/md/.gitignore
@@ -0,0 +1,4 @@
+mktables
+raid6altivec*.c
+raid6int*.c
+raid6tables.c
diff --git a/drivers/net/wan/.gitignore b/drivers/net/wan/.gitignore
new file mode 100644
index 0000000..dae3ea6
--- /dev/null
+++ b/drivers/net/wan/.gitignore
@@ -0,0 +1 @@
+wanxlfw.inc
diff --git a/drivers/scsi/.gitignore b/drivers/scsi/.gitignore
new file mode 100644
index 0000000..b385af3
--- /dev/null
+++ b/drivers/scsi/.gitignore
@@ -0,0 +1,3 @@
+53c700_d.h
+53c7xx_d.h
+53c7xx_u.h
diff --git a/drivers/scsi/aic7xxx/.gitignore b/drivers/scsi/aic7xxx/.gitignore
new file mode 100644
index 0000000..b8ee24d
--- /dev/null
+++ b/drivers/scsi/aic7xxx/.gitignore
@@ -0,0 +1,6 @@
+aic79xx_reg.h
+aic79xx_reg_print.c
+aic79xx_seq.h
+aic7xxx_reg.h
+aic7xxx_reg_print.c
+aic7xxx_seq.h
diff --git a/scripts/genksyms/.gitignore b/scripts/genksyms/.gitignore
new file mode 100644
index 0000000..be5cadb
--- /dev/null
+++ b/scripts/genksyms/.gitignore
@@ -0,0 +1,4 @@
+keywords.c
+lex.c
+parse.[ch]
+genksyms
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 2dac344..e8ad1f6 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -5,6 +5,7 @@ config*
 lex.*.c
 *.tab.c
 *.tab.h
+zconf.hash.c
 
 #
 # configuration programs
-- 
1.0.6

