Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTA2QmI>; Wed, 29 Jan 2003 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTA2QmI>; Wed, 29 Jan 2003 11:42:08 -0500
Received: from mailrelay2.lanl.gov ([128.165.4.103]:44675 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S266431AbTA2QmH>; Wed, 29 Jan 2003 11:42:07 -0500
Subject: [PATCH] 2.5.59 add one help text to drivers/atm/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 29 Jan 2003 09:49:05 -0700
Message-Id: <1043858946.2576.197.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a help text from 2.4.21-pre4 Configure.help which is
needed in 2.5.59 drivers/atm/Kconfig.

Steven

--- linux-2.5.59/drivers/atm/Kconfig.orig	Wed Jan 29 09:27:38 2003
+++ linux-2.5.59/drivers/atm/Kconfig	Wed Jan 29 09:28:16 2003
@@ -15,6 +15,11 @@
 config ATM_LANAI
 	tristate "Efficient Networks Speedstream 3010"
 	depends on PCI
+	help
+	  Supports ATM cards based on the Efficient Networks "Lanai"
+	  chipset such as the Speedstream 3010 and the ENI-25p.  The
+	  Speedstream 3060 is currently not supported since we don't
+	  have the code to drive the on-board Alcatel DSL chipset (yet).
 
 config ATM_ENI
 	tristate "Efficient Networks ENI155P"




