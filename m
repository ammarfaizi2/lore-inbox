Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVL1Em4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVL1Em4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVL1Em4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:42:56 -0500
Received: from quark.didntduck.org ([69.55.226.66]:50309 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932473AbVL1Emz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:42:55 -0500
Message-ID: <43B217F3.8040305@didntduck.org>
Date: Tue, 27 Dec 2005 23:43:31 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] gitignore misc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore all files generated from *_shipped files, plus a few others.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit e2b05fa2a24014bb2331d135523ca19e967a7063
tree d9062916ca636b7aae361e8690afcb61bfb6b956
parent 0e5f0274a2e711e54304c05114d48e4b56e42c21
author Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:42:41 -0500
committer Brian Gerst <bgerst@didntduck.org> Tue, 27 Dec 2005 23:42:41 -0500

 drivers/char/.gitignore         |    2 +-
 drivers/ieee1394/.gitignore     |    1 +
 drivers/md/.gitignore           |    4 ++++
 drivers/net/wan/.gitignore      |    1 +
 drivers/scsi/.gitignore         |    3 +++
 drivers/scsi/aic7xxx/.gitignore |    6 ++++++
 scripts/genksyms/.gitignore     |    4 ++++
 scripts/kconfig/.gitignore      |    1 +
 8 files changed, 21 insertions(+), 1 deletions(-)

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


