Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269781AbUJSSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269781AbUJSSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUJSQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:56:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:48324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269774AbUJSQim convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:38:42 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9
In-Reply-To: <1098203812166@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 19 Oct 2004 09:36:55 -0700
Message-Id: <10982038153853@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1946.10.13, 2004/09/24 19:23:11-07:00, mochel@digitalimplant.org

[driver core] Change symbol exports to GPL only in power/main.c

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	2004-10-19 09:21:12 -07:00
+++ b/drivers/base/power/main.c	2004-10-19 09:21:12 -07:00
@@ -66,7 +66,7 @@
 	dev->power.pm_parent = parent;
 	device_pm_hold(parent);
 }
-EXPORT_SYMBOL(device_pm_set_parent);
+EXPORT_SYMBOL_GPL(device_pm_set_parent);
 
 int device_pm_add(struct device * dev)
 {

