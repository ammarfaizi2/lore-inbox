Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318774AbSHLRfL>; Mon, 12 Aug 2002 13:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318773AbSHLRfG>; Mon, 12 Aug 2002 13:35:06 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:61131 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S318772AbSHLRec>; Mon, 12 Aug 2002 13:34:32 -0400
Subject: [PATCH] 2.5.31 add one help text to drivers/atm/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 12 Aug 2002 11:35:28 -0600
Message-Id: <1029173728.2051.41.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a help text to drivers/atm/Config.help for
CONFIG_ATM_LANAI. 

This has been in the -dj tree since about 2.5.7.
The text was obtained from ESR's v2.97 Configure.help. 

Steven


--- linux-2.5.31/drivers/atm/Config.help.orig	Mon Aug 12 11:06:38 2002
+++ linux-2.5.31/drivers/atm/Config.help	Mon Aug 12 11:08:49 2002
@@ -2,6 +2,12 @@
   ATM over TCP driver. Useful mainly for development and for
   experiments. If unsure, say N.
 
+CONFIG_ATM_LANAI
+  Supports ATM cards based on the Efficient Networks "Lanai"
+  chipset such as the Speedstream 3010 and the ENI-25p.  The
+  Speedstream 3060 is currently not supported since we don't
+  have the code to drive the on-board Alcatel DSL chipset (yet).
+
 CONFIG_ATM_ENI
   Driver for the Efficient Networks ENI155p series and SMC ATM
   Power155 155 Mbps ATM adapters. Both, the versions with 512KB and




