Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTHOS1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270716AbTHOSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:59778 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270709AbTHOSZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:33 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719473549@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719472782@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.2, 2003/08/14 16:51:20-07:00, greg@kroah.com

Remove .name usage from floppy driver.


 drivers/block/floppy.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Fri Aug 15 11:16:09 2003
+++ b/drivers/block/floppy.c	Fri Aug 15 11:16:09 2003
@@ -4228,9 +4228,6 @@
 static struct platform_device floppy_device = {
 	.name		= "floppy",
 	.id		= 0,
-	.dev		= {
-		.name	= "Floppy Drive",
-	},
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)

