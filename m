Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRCHPxe>; Thu, 8 Mar 2001 10:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRCHPxX>; Thu, 8 Mar 2001 10:53:23 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:28061 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129156AbRCHPxO>; Thu, 8 Mar 2001 10:53:14 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Thu, 8 Mar 2001 08:52:20 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] remove CONFIG_NCR885E from Configure.help
MIME-Version: 1.0
Message-Id: <01030808522000.01048@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that use of CONFIG_NCR885E was removed in 2.4.2-ac2,
in Config.in and the Makefile in drivers/net.

If it really is the case that CONFIG_NCR885E is history, then it
should be history in Configure.help as well.

This patch, against 2.4.2-ac14, removes CONFIG_NCR885E from Configure.help.

Steven

--- linux/Documentation/Configure.help.orig     Thu Mar  8 08:26:11 2001
+++ linux/Documentation/Configure.help  Thu Mar  8 08:43:36 2001
@@ -16511,16 +16511,6 @@
   whenever you want). If you want to compile it as a module, say M
   here and read Documentation/modules.txt.
 
-Symbios 53c885 (Synergy ethernet) support
-CONFIG_NCR885E
-  This is and Ethernet driver for the dual-function NCR 53C885
-  SCSI/Ethernet controller.
-
-  This driver is also available as a module called ncr885e.o ( = code
-  which can be inserted in and removed from the running kernel
-  whenever you want). If you want to compile it as a module, say M
-  here and read Documentation/modules.txt.
-
 National DP83902AV (Oak ethernet) support
 CONFIG_OAKNET
   Say Y if your machine has this type of Ethernet network card.
