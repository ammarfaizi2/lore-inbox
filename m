Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWCXNyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWCXNyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCXNyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:54:53 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:52102 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932619AbWCXNyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:54:52 -0500
Date: Fri, 24 Mar 2006 07:54:51 -0600
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Matt_Domsch@dell.com
Subject: [PATCH] Increment IPMI driver version to v39.0
Message-ID: <20060324135451.GA7557@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Need to increment the version number because of the new PCI and
sysfs capabilities of the driver.  People maintaining things for
distros have asked that I do this after interface or major
functional changes.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -48,7 +48,7 @@
 
 #define PFX "IPMI message handler: "
 
-#define IPMI_DRIVER_VERSION "38.0"
+#define IPMI_DRIVER_VERSION "39.0"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
