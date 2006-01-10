Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWAJU5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWAJU5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAJU53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:57:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64521 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932628AbWAJU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:57:11 -0500
Date: Tue, 10 Jan 2006 21:57:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] ftape: remove some outdated information from Kconfig files
Message-ID: <20060110205709.GE3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some outdated information about the ftape driver like 
pointers to no longer existing webpages from Kconfig files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/Kconfig       |   10 ----------
 drivers/char/ftape/Kconfig |   12 +-----------
 2 files changed, 1 insertion(+), 21 deletions(-)

--- linux-2.6.15-mm2-full/drivers/char/Kconfig.old	2006-01-10 21:32:49.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/char/Kconfig	2006-01-10 21:33:11.000000000 +0100
@@ -881,16 +881,6 @@
 	  module. To compile this driver as a module, choose M here: the
 	  module will be called ftape.
 
-	  Note that the Ftape-HOWTO is out of date (sorry) and documents the
-	  older version 2.08 of this software but still contains useful
-	  information.  There is a web page with more recent documentation at
-	  <http://www.instmath.rwth-aachen.de/~heine/ftape/>.  This page
-	  always contains the latest release of the ftape driver and useful
-	  information (backup software, ftape related patches and
-	  documentation, FAQ).  Note that the file system interface has
-	  changed quite a bit compared to previous versions of ftape.  Please
-	  read <file:Documentation/ftape.txt>.
-
 source "drivers/char/ftape/Kconfig"
 
 endmenu
--- linux-2.6.15-mm2-full/drivers/char/ftape/Kconfig.old	2006-01-10 21:33:21.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/char/ftape/Kconfig	2006-01-10 21:34:02.000000000 +0100
@@ -25,17 +25,7 @@
 	  support", above) then `zft-compressor' will be loaded
 	  automatically by zftape when needed.
 
-	  Despite its name, zftape does NOT use compression by default.  The
-	  file <file:Documentation/ftape.txt> contains a short description of
-	  the most important changes in the file system interface compared to
-	  previous versions of ftape.  The ftape home page
-	  <http://www.instmath.rwth-aachen.de/~heine/ftape/> contains
-	  further information.
-
-	  IMPORTANT NOTE: zftape can read archives created by previous
-	  versions of ftape and provide file mark support (i.e. fast skipping
-	  between tape archives) but previous version of ftape will lack file
-	  mark support when reading archives produced by zftape.
+	  Despite its name, zftape does NOT use compression by default.
 
 config ZFT_DFLT_BLK_SZ
 	int "Default block size"

