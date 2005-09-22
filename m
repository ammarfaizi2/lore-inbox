Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVIVFBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVIVFBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVIVFBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:01:24 -0400
Received: from xenotime.net ([66.160.160.81]:35738 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030216AbVIVFBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:01:24 -0400
Date: Wed, 21 Sep 2005 22:01:14 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, blaisorblade@yahoo.it
Subject: [PATCH] corrections to top-level README
Message-Id: <20050921220114.32d4c283.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Corrections to the recent top-level README changes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 README |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -Naurp linux-2614-rc2/README~readme_ancient linux-2614-rc2/README
--- linux-2614-rc2/README~readme_ancient	2005-09-21 21:53:49.000000000 -0700
+++ linux-2614-rc2/README	2005-09-21 21:56:58.000000000 -0700
@@ -151,7 +151,7 @@ CONFIGURING the kernel:
 			   your existing ./.config file.
 	"make silentoldconfig"
 			   Like above, but avoids cluttering the screen
-			   with question already answered.
+			   with questions already answered.
    
 	NOTES on "make config":
 	- having unnecessary drivers will make the kernel bigger, and can
@@ -199,9 +199,9 @@ COMPILING the kernel:
    are installing a new kernel with the same version number as your
    working kernel, make a backup of your modules directory before you
    do a "make modules_install".
-   In alternative, before compiling, edit your Makefile and change the
-   "EXTRAVERSION" line - its content is appended to the regular kernel
-   version.
+   Alternatively, before compiling, use the kernel config option
+   "LOCALVERSION" to append a unique suffix to the regular kernel version.
+   LOCALVERSION can be set in the "General Setup" menu.
 
  - In order to boot your new kernel, you'll need to copy the kernel
    image (e.g. .../linux/arch/i386/boot/bzImage after compilation)


---
