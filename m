Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292897AbSBVPXJ>; Fri, 22 Feb 2002 10:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292896AbSBVPWu>; Fri, 22 Feb 2002 10:22:50 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:16558 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S292891AbSBVPWn>; Fri, 22 Feb 2002 10:22:43 -0500
Message-Id: <200202221434.HAA16547@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Werner Almesberger <wa@almesberger.net>
Subject: [PATCH] 2.5.5-dj1 add one help text to drivers/atm/Config.help
Date: Fri, 22 Feb 2002 08:20:48 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_ATM_LANAI in drivers/atm/Config.help.

Patch is made against 2.5.5-dj1.

Steven

--- linux-2.5.5-dj1/drivers/atm/Config.help.orig        Thu Feb 21 15:32:01 2002
+++ linux-2.5.5-dj1/drivers/atm/Config.help     Thu Feb 21 15:34:37 2002
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
