Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUBIXTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUBIXTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:19:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:47291 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265367AbUBIXTf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:35 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <10763687741938@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:34 -0800
Message-Id: <10763687741075@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.2, 2004/01/30 16:56:36-08:00, ender@debian.org

[PATCH] I2C: fix typos

Following patch fixes two typos and a missing full stop.


 drivers/i2c/chips/lm85.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Feb  9 15:06:03 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Feb  9 15:06:03 2004
@@ -816,7 +816,7 @@
 			kind = lm85b ;
 		} else if( company == LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
@@ -827,7 +827,7 @@
 			kind = adt7463 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) == LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to ADM1027.\n", verstep);
 			kind = adm1027 ;
 		} else if( kind == 0 && (verstep & 0xf0) == 0x60) {
@@ -1204,7 +1204,7 @@
 
 /* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
  * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- *     post 2.7.0 CVS changes
+ *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");

