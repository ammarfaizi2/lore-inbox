Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269691AbUJSQ6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269691AbUJSQ6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJSQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:57:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:47044 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269691AbUJSQil convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:41 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <10982038183359@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:37:00 -0700
Message-Id: <10982038201196@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.15, 2004/09/24 19:25:13-07:00, mochel@digitalimplant.org

[driver core] Change symbol exports to GPL only in power/suspend.c.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/suspend.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	2004-10-19 09:21:01 -07:00
+++ b/drivers/base/power/suspend.c	2004-10-19 09:21:01 -07:00
@@ -100,7 +100,7 @@
 	goto Done;
 }
 
-EXPORT_SYMBOL(device_suspend);
+EXPORT_SYMBOL_GPL(device_suspend);
 
 
 /**
@@ -132,5 +132,5 @@
 	goto Done;
 }
 
-EXPORT_SYMBOL(device_power_down);
+EXPORT_SYMBOL_GPL(device_power_down);
 

