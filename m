Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293515AbSCGOi5>; Thu, 7 Mar 2002 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310170AbSCGOir>; Thu, 7 Mar 2002 09:38:47 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:60595 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S293515AbSCGOii>; Thu, 7 Mar 2002 09:38:38 -0500
Message-Id: <200203071350.GAA05585@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.5-dj3, small update to drivers/telephony/Config.help
Date: Thu, 7 Mar 2002 07:36:14 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the help text for CONFIG_PHONE_IXJ_PCMCIA in
drivers/telephony/Config.help.  The text was improved by Alan Cox
in 2.4.19-pre2-ac3.  This patch will also apply to 2.5.6-pre3.

Steven

--- linux-2.5.5-dj3/drivers/telephony/Config.help.orig  Thu Mar  7 07:25:22 2002
+++ linux-2.5.5-dj3/drivers/telephony/Config.help       Thu Mar  7 07:26:04 2002
@@ -28,6 +28,6 @@

 CONFIG_PHONE_IXJ_PCMCIA
   Say Y here to configure in PCMCIA service support for the Quicknet
-  cards manufactured by Quicknet Technologies, Inc.  This changes the
-  card initialization code to work with the card manager daemon.
+  cards manufactured by Quicknet Technologies, Inc.  This builds an
+  additional support module for the PCMCIA version of the card.
