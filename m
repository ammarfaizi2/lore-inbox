Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291923AbSBNV2n>; Thu, 14 Feb 2002 16:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291927AbSBNV2d>; Thu, 14 Feb 2002 16:28:33 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:61396 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S291923AbSBNV2P>; Thu, 14 Feb 2002 16:28:15 -0500
Message-Id: <200202142039.NAA05035@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] 2.5.5-pre1 add 1 help text to drivers/isdn/Config.help
Date: Thu, 14 Feb 2002 14:25:58 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_HISAX_MAX_CARDS to drivers/isdn/Config.help.

Steven

--- linux-2.5.5-pre1/drivers/isdn/Config.help.orig      Thu Feb 14 13:24:27 2002
+++ linux-2.5.5-pre1/drivers/isdn/Config.help   Thu Feb 14 13:30:47 2002
@@ -161,6 +161,10 @@
   Enable this if you like to use ISDN in US on a NI1 basic rate
   interface.

+CONFIG_HISAX_MAX_CARDS
+  This is used to allocate a driver-internal structure array with one
+  entry for each HiSax card on your system.
+
 CONFIG_HISAX_16_0
   This enables HiSax support for the Teles ISDN-cards S0-16.0, S0-8
   and many compatibles.

