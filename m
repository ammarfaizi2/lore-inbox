Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVADOwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVADOwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVADOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:52:31 -0500
Received: from [212.20.225.142] ([212.20.225.142]:61461 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261669AbVADOus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:50:48 -0500
Subject: [PATCH 2/2] AC97 plugin suspend/resume
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-nXTPuZKWPJMKIJGFawyM"
Message-Id: <1104850247.9143.335.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Jan 2005 14:50:47 +0000
X-OriginalArrivalTime: 04 Jan 2005 14:50:48.0426 (UTC) FILETIME=[C71E54A0:01C4F26C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nXTPuZKWPJMKIJGFawyM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch sets suspend and resume to NULL in the ad1980 plugin.

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

Liam

--=-nXTPuZKWPJMKIJGFawyM
Content-Disposition: attachment; filename=ac97_plugin_ad1980.diff
Content-Type: text/x-patch; name=ac97_plugin_ad1980.diff; charset=
Content-Transfer-Encoding: 7bit

--- a/sound/oss/ac97_plugin_ad1980.c	2004-12-24 21:33:48.000000000 +0000
+++ b/sound/oss/ac97_plugin_ad1980.c	2005-01-04 14:15:40.000000000 +0000
@@ -89,6 +89,8 @@
 	.name		= "AD1980 example",
 	.probe		= ad1980_probe,
 	.remove		= __devexit_p(ad1980_remove),
+	.suspend	= NULL,
+	.resume		= NULL,
 };
 
 /**

--=-nXTPuZKWPJMKIJGFawyM--

