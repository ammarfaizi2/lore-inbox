Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbTHWGbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbTHWGbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:31:49 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:26008 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261636AbTHWGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:31:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 2.6] Input: typo in device matching
Date: Sat, 23 Aug 2003 01:31:41 -0500
User-Agent: KMail/1.5.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308230131.41135.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

There was a bit too much of cut-n-paste in input.c.

Dmitry


diff -urN --exclude-from=/usr/src/exclude 2.5.72-vanilla/drivers/input/input.c linux-2.5.72/drivers/input/input.c
--- 2.5.72-vanilla/drivers/input/input.c	2003-06-19 20:23:32.000000000 -0500
+++ linux-2.5.72/drivers/input/input.c	2003-06-23 22:15:49.000000000 -0500
@@ -280,7 +280,7 @@
 			if (id->id.product != dev->id.product)
 				continue;
 		
-		if (id->flags & INPUT_DEVICE_ID_MATCH_BUS)
+		if (id->flags & INPUT_DEVICE_ID_MATCH_VERSION)
 			if (id->id.version != dev->id.version)
 				continue;
 
