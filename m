Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVCYF53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVCYF53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVCYF5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:57:00 -0500
Received: from digitalimplant.org ([64.62.235.95]:14291 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261428AbVCYFzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:55:08 -0500
Date: Thu, 24 Mar 2005 21:54:58 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [12/12] More Driver Model Locking Changes
Message-ID: <Pine.LNX.4.50.0503242153190.19795-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.2250, 2005-03-24 20:08:04-08:00, mochel@digitalimplant.org
  [driver core] Fix up bogus comment.
  Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>

diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2005-03-24 20:32:39 -08:00
+++ b/drivers/base/driver.c	2005-03-24 20:32:39 -08:00
@@ -31,8 +31,7 @@
  *	@data:	Data to pass to the callback.
  *	@fn:	Function to call for each device.
  *
- *	Take the bus's rwsem and iterate over the @drv's list of devices,
- *	calling @fn for each one.
+ *	Iterate over the @drv's list of devices calling @fn for each one.
  */

 int driver_for_each_device(struct device_driver * drv, struct device * start,
