Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUDNWs0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDNWml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:42:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:54431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261991AbUDNWZT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:19 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814502943@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <10819814501036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.11, 2004/03/30 14:27:21-08:00, khali@linux-fr.org

[PATCH] I2C: Discard pointless comment in via686a

The simple patch below discards a comment in via686a referencing a file
that doesn't belong to the Linux tree. Now that I tell people not to do
that in my porting guide, we better follow our own advice.


 drivers/i2c/chips/via686a.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr 14 15:14:05 2004
+++ b/drivers/i2c/chips/via686a.c	Wed Apr 14 15:14:05 2004
@@ -27,7 +27,6 @@
 /*
     Supports the Via VT82C686A, VT82C686B south bridges.
     Reports all as a 686A.
-    See doc/chips/via686a for details.
     Warning - only supports a single device.
 */
 

