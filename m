Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVAHHlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVAHHlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVAHHhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:37:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:44677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261861AbVAHFsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:17 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632582690@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <1105163258285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.2, 2004/12/15 10:49:05-08:00, greg@kroah.com

[PATCH] misc: remove device.h #include from miscdevice.h

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/miscdevice.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h	2005-01-07 15:52:00 -08:00
+++ b/include/linux/miscdevice.h	2005-01-07 15:52:00 -08:00
@@ -2,7 +2,6 @@
 #define _LINUX_MISCDEVICE_H
 #include <linux/module.h>
 #include <linux/major.h>
-#include <linux/device.h>
 
 #define PSMOUSE_MINOR  1
 #define MS_BUSMOUSE_MINOR 2
@@ -32,6 +31,7 @@
 #define	HPET_MINOR	     228
 
 struct device;
+struct class_device;
 
 struct miscdevice  {
 	int minor;

