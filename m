Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTL2VUM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTL2VUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:20:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:51725 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264272AbTL2VUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:20:07 -0500
From: Stephan Maciej <stephanm@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0: Change cryptic description and help for CONFIG_PDC202XX_FORCE
Date: Mon, 29 Dec 2003 04:15:00 +0100
User-Agent: KMail/1.5.94
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0w57/bSFBi3CEWa"
Message-Id: <200312290415.00502.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0w57/bSFBi3CEWa
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The description and the help text for this option has bothered me long 
enough... I hope the new strings are more self-explanatory than the ones 
before.

Stephan

--Boundary-00=_0w57/bSFBi3CEWa
Content-Type: text/x-diff;
  charset="us-ascii";
  name="kconfig-pdc202xx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kconfig-pdc202xx.diff"

--- drivers/ide/Kconfig.orig	2003-12-29 04:00:06.000000000 +0100
+++ drivers/ide/Kconfig	2003-12-29 04:05:24.000000000 +0100
@@ -734,10 +734,10 @@
 
 # FIXME - probably wants to be one for old and for new
 config PDC202XX_FORCE
-	bool "Special FastTrak Feature"
+	bool "Enable controller even if disabled by BIOS"
 	depends on BLK_DEV_PDC202XX_NEW=y
 	help
-	  For FastTrak enable overriding BIOS.
+	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
 
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"

--Boundary-00=_0w57/bSFBi3CEWa--
