Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVEAROm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVEAROm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVEAROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 13:14:35 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:39697 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262622AbVEARO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 13:14:29 -0400
Date: Sun, 1 May 2005 19:15:20 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       Corey Minyard <minyard@acm.org>
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (1/3)
Message-Id: <20050501191520.7bc41d1b.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in a comment in i2c.h. It was originally fixed by Corey
Minyard in Linux 2.6.

http://linux.bkbits.net:8080/linux-2.5/diffs/include/linux/i2c.h@1.48

--- linux-2.4.30-rc1/include/linux/i2c.h.orig	2005-03-19 13:16:55.000000000 +0100
+++ linux-2.4.30-rc1/include/linux/i2c.h	2005-03-19 13:17:40.000000000 +0100
@@ -193,7 +193,7 @@
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
-	/* If an adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't do I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */


-- 
Jean Delvare
