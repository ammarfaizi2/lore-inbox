Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTETWse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTETWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:48:33 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:22948 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261444AbTETWsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:48:05 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 08/14] USB speedtouch: remove stale code
Date: Wed, 21 May 2003 01:01:00 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210101.00075.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should have gone long ago.

 speedtch.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:40:37 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:40:37 2003
@@ -812,9 +812,6 @@
 		return -ENODEV;
 	}
 
-	if (!instance->firmware_loaded)
-		return -EAGAIN;
-
 	if (vcc->qos.aal != ATM_AAL5) {
 		dbg ("udsl_atm_send: unsupported ATM type %d!", vcc->qos.aal);
 		return -EINVAL;

