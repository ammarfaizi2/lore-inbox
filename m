Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWFZA6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWFZA6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWFZA6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:34 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16015 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964975AbWFZA6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:19 -0400
Date: Sun, 25 Jun 2006 17:58:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 10/43] Remove prototype for name_to_dev_t()
Message-Id: <klibc.200606251757.10@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
(cherry picked from adcfc2bd22397db1dda1bd2b8a7bcb0f0b7300e7 commit)

---
commit 869206cac1cb04d54582dc4383248ee9721073e8
tree 6ff1c26fecb794b44b6df91cdb113856ab454666
parent a36102c485caf951294301425ee8e87aa6ab4d92
author H. Peter Anvin <hpa@zytor.com> Thu, 30 Mar 2006 12:03:47 -0800
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:47:13 -0700

 include/linux/mount.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index b7472ae..1af8a41 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -81,7 +81,6 @@ extern int do_add_mount(struct vfsmount 
 extern void mark_mounts_for_expiry(struct list_head *mounts);
 
 extern spinlock_t vfsmount_lock;
-extern dev_t name_to_dev_t(char *name);
 
 #endif
 #endif /* _LINUX_MOUNT_H */
