Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbUA0XjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbUA0XhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:37:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:36031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265263AbUA0XeQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:34:16 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.2-rc2
In-Reply-To: <1075246453680@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 27 Jan 2004 15:34:13 -0800
Message-Id: <1075246453858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.148.2, 2004/01/23 17:14:38-08:00, khali@linux-fr.org

[PATCH] I2C: undo documentation change

Undo a recent change to the i2c documentation. The change belongs to
2.7.


 Documentation/i2c/porting-clients |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	Tue Jan 27 15:27:19 2004
+++ b/Documentation/i2c/porting-clients	Tue Jan 27 15:27:19 2004
@@ -92,10 +92,7 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
-  by module_param(). Note that module_param has a third parameter,
-  that you should set to 0 by default. See include/linux/moduleparam.h
-  for details.
+  there is a MODULE_LICENSE() line.
 
 Coding policy:
 

