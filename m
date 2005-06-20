Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVFTXpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVFTXpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFTXpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:45:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:62436 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261790AbVFTXAL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:00:11 -0400
Cc: yani.ioannou@gmail.com
Subject: [PATCH] Driver Core: include: update device attribute callbacks
In-Reply-To: <11193083694078@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <111930836940@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: include: update device attribute callbacks

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f2d03e1b3f00f1c5971463ab0101bef0c521ad3b
tree 44b0daa72e356e830066d0027f128106d7476ddb
parent 060b8845e6bea938d65ad6f89e83507e5ff4fec4
author Yani Ioannou <yani.ioannou@gmail.com> Tue, 17 May 2005 06:44:59 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:35 -0700

 include/asm-ppc/ocp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
--- a/include/asm-ppc/ocp.h
+++ b/include/asm-ppc/ocp.h
@@ -189,7 +189,7 @@ extern void ocp_for_each_device(void(*ca
 /* Sysfs support */
 #define OCP_SYSFS_ADDTL(type, format, name, field)			\
 static ssize_t								\
-show_##name##_##field(struct device *dev, char *buf)			\
+show_##name##_##field(struct device *dev, struct device_attribute *attr, char *buf)			\
 {									\
 	struct ocp_device *odev = to_ocp_dev(dev);			\
 	type *add = odev->def->additions;				\

