Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293224AbSB1Q2h>; Thu, 28 Feb 2002 11:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSB1QZS>; Thu, 28 Feb 2002 11:25:18 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:934 "EHLO tstac.esa.lanl.gov")
	by vger.kernel.org with ESMTP id <S293459AbSB1QYh>;
	Thu, 28 Feb 2002 11:24:37 -0500
Message-Id: <200202281536.IAA26508@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.5-dj2, add 1 help text to drivers/telephony/Config.help
Date: Thu, 28 Feb 2002 09:22:41 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_PHONE_IXJ_PCMCIA to
drivers/telephony/Config.help.  The text was obtained from
Eric Raymond's Configure.help v2.97.

Steven

--- linux-2.5.5-dj2/drivers/telephony/Config.help.orig  Thu Feb 28 08:54:28 2002
+++ linux-2.5.5-dj2/drivers/telephony/Config.help       Thu Feb 28 08:55:49 2002
@@ -26,3 +26,8 @@
   If you do not have any Quicknet telephony cards, you can safely
   say N here.

+CONFIG_PHONE_IXJ_PCMCIA
+  Say Y here to configure in PCMCIA service support for the Quicknet
+  cards manufactured by Quicknet Technologies, Inc.  This changes the
+  card initialization code to work with the card manager daemon.
+
