Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUDNWs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUDNWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:42:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:55199 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261992AbUDNWZU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:20 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <1081981449280@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:09 -0700
Message-Id: <10819814492936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.3, 2004/03/25 10:50:47-08:00, khali@linux-fr.org

[PATCH] I2C: Discard out-of-date comment in adm1021 driver

This simple patch discards an out-of-date comment in the adm1021 driver.
I've done the same in our CVS repository where many more drivers were
affected.

I agree it's not very important, but I prefer it to be done before any
driver with the error is used as a base to port a new driver, and the
misinformation spreads.


 drivers/i2c/chips/adm1021.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:49 2004
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr 14 15:14:49 2004
@@ -151,9 +151,6 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-/* I choose here for semi-static allocation. Complete dynamic
-   allocation could also be used; the code needed for this would probably
-   take more memory than the datastructure takes now. */
 static int adm1021_id = 0;
 
 #define show(value)	\

