Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVFUCQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVFUCQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFUCQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:16:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:34276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261744AbVFTW7t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:49 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Fix up bogus comment.
In-Reply-To: <11193083662698@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <1119308366271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix up bogus comment.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c

---
commit 4d12d2d953ca5e299de6a653f1d0478f670d7bc6
tree ba89978abb57da6a24cc141b869a14b6d6c76884
parent 36239577cfb6b9a7c111209536b54200b0252ebf
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 20:08:04 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:23 -0700

 drivers/base/driver.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -31,8 +31,7 @@ static struct device * next_device(struc
  *	@data:	Data to pass to the callback.
  *	@fn:	Function to call for each device.
  *
- *	Take the bus's rwsem and iterate over the @drv's list of devices,
- *	calling @fn for each one.
+ *	Iterate over the @drv's list of devices calling @fn for each one.
  */
 
 int driver_for_each_device(struct device_driver * drv, struct device * start, 

