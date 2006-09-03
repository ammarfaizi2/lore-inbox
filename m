Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWICP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWICP6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWICP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 11:58:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57558 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1751332AbWICP6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 11:58:52 -0400
Message-ID: <44FAFC01.8090507@web.de>
Date: Sun, 03 Sep 2006 18:00:01 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/ABI: devfs is not obsolete, but removed!
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody, Greg, Linus,

This little patch just moves the devfs entry from ABI/obsolete to
ABI/removed and adds the comment, that devfs was removed in 2.6.18.

The patch is against linus' current git tree and should go into the final
2.6.18.

Kind regards, Jens


Signed-off-by: jens m. noedler <noedler@web.de>

---

diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/obsolete/devfs
deleted file mode 100644
index b8b8739..0000000
--- a/Documentation/ABI/obsolete/devfs
+++ /dev/null
@@ -1,13 +0,0 @@
-What:		devfs
-Date:		July 2005
-Contact:	Greg Kroah-Hartman <gregkh@suse.de>
-Description:
-	devfs has been unmaintained for a number of years, has unfixable
-	races, contains a naming policy within the kernel that is
-	against the LSB, and can be replaced by using udev.
-	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
-	along with the the assorted devfs function calls throughout the
-	kernel tree.
-
-Users:
-
diff --git a/Documentation/ABI/removed/devfs b/Documentation/ABI/removed/devfs
new file mode 100644
index 0000000..e360fa9
--- /dev/null
+++ b/Documentation/ABI/removed/devfs
@@ -0,0 +1,12 @@
+What:		devfs
+Date:		July 2005 (scheduled), finally removed in kernel v2.6.18
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:



-- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de





-- 
VGER BF report: U 0.740655
