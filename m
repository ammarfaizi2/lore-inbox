Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269789AbUJSQwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269789AbUJSQwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbUJSQvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:51:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:54212 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269790AbUJSQir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:47 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <109820379375@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:35 -0700
Message-Id: <1098203795555@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.4, 2004/09/24 11:45:06-07:00, mochel@digitalimplant.org

[driver model] Change symbol exports to GPL only in driver.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/driver.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2004-10-19 09:21:58 -07:00
+++ b/drivers/base/driver.c	2004-10-19 09:21:58 -07:00
@@ -129,11 +129,11 @@
 	return NULL;
 }
 
-EXPORT_SYMBOL(driver_register);
-EXPORT_SYMBOL(driver_unregister);
-EXPORT_SYMBOL(get_driver);
-EXPORT_SYMBOL(put_driver);
-EXPORT_SYMBOL(driver_find);
+EXPORT_SYMBOL_GPL(driver_register);
+EXPORT_SYMBOL_GPL(driver_unregister);
+EXPORT_SYMBOL_GPL(get_driver);
+EXPORT_SYMBOL_GPL(put_driver);
+EXPORT_SYMBOL_GPL(driver_find);
 
-EXPORT_SYMBOL(driver_create_file);
-EXPORT_SYMBOL(driver_remove_file);
+EXPORT_SYMBOL_GPL(driver_create_file);
+EXPORT_SYMBOL_GPL(driver_remove_file);

