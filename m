Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEFLMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEFLMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWEFLMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:12:34 -0400
Received: from tim.rpsys.net ([194.106.48.114]:14800 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750763AbWEFLMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:12:33 -0400
Subject: [PATCH] LED: Improve Kconfig information
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 06 May 2006 12:12:18 +0100
Message-Id: <1146913939.6237.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the NEW_LEDS Kconfig information to say what it does as well 
as what it doesn't.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/leds/Kconfig
===================================================================
--- git.orig/drivers/leds/Kconfig	2006-05-04 23:12:57.000000000 +0100
+++ git/drivers/leds/Kconfig	2006-05-06 10:21:08.000000000 +0100
@@ -4,8 +4,11 @@
 config NEW_LEDS
 	bool "LED Support"
 	help
-	  Say Y to enable Linux LED support.  This is not related to standard
-	  keyboard LEDs which are controlled via the input system.
+	  Say Y to enable Linux LED support.  This allows control of supported
+	  LEDs from both userspace and optionally, by kernel events (triggers).
+
+	  This is not related to standard keyboard LEDs which are controlled
+	  via the input system.
 
 config LEDS_CLASS
 	tristate "LED Class Support"


