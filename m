Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVFTXlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVFTXlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFTXil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:38:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:63972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261792AbVFTXAN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:13 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver core: Documentation: update device attribute callbacks
In-Reply-To: <11193083682616@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083681864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: Documentation: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 3eb8c7836eb074b61d63597be3e4f085814ac4c0
tree 41256899f1451a7e4fe0c764e15195c967e988ca
parent 54b6f35c99974e99e64c05c2895718355123c55f
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:40:28 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:32 -0700

 Documentation/filesystems/sysfs.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.txt
@@ -214,7 +214,7 @@ Other notes:
 
 A very simple (and naive) implementation of a device attribute is:
 
-static ssize_t show_name(struct device * dev, char * buf)
+static ssize_t show_name(struct device *dev, struct device_attribute *attr, char *buf)
 {
         return sprintf(buf,"%s\n",dev->name);
 }

