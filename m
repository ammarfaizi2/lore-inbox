Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVKNOdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVKNOdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 09:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVKNOdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 09:33:05 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:35036 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751134AbVKNOdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 09:33:04 -0500
Date: Mon, 14 Nov 2005 08:32:53 -0600
From: Corey Minyard <minyard@acm.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: bump-driver-version
Message-ID: <20051114143253.GA15994@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of good changes to the driver lately that userspace will care
about the version of the driver.  Bump the version from 36.0 to 38.0
to be higher than 37 that the 2.4 driver came out with a few weeks ago
which doesn't have all the same changes.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

--- linux-2.6/drivers/char/ipmi/ipmi_msghandler.c.orig	Mon Nov  7 14:26:14 2005
+++ linux-2.6/drivers/char/ipmi/ipmi_msghandler.c	Mon Nov  7 14:26:20 2005
@@ -48,7 +48,7 @@
 
 #define PFX "IPMI message handler: "
 
-#define IPMI_DRIVER_VERSION "36.0"
+#define IPMI_DRIVER_VERSION "38.0"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
