Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUFVSHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUFVSHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUFVSGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:06:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:34229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265054AbUFVRnV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:21 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261083437@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:48 -0700
Message-Id: <10879261081887@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.85.3, 2004/06/03 10:27:16-07:00, mochel@digitalimplant.org

[sysfs] Add attr_name() macro

- Returns the name of an embedded attribute in a higher-level 
  attribute.


 include/linux/sysfs.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Tue Jun 22 09:49:05 2004
+++ b/include/linux/sysfs.h	Tue Jun 22 09:49:05 2004
@@ -43,7 +43,7 @@
 
 #define __ATTR_NULL { .attr = { .name = NULL } }
 
-
+#define attr_name(_attr) (_attr).attr.name
 
 struct bin_attribute {
 	struct attribute	attr;

