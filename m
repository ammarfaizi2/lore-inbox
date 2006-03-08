Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWCHVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWCHVYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCHVYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:24:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8717 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932404AbWCHVYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:24:48 -0500
Date: Wed, 8 Mar 2006 22:24:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/kobject.h: fix a typo
Message-ID: <20060308212446.GN4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shouldn't cause real harm, but it hurts my eyes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2006

--- linux-2.6.16-rc5-mm2-full/include/linux/kobject.h.old	2006-03-04 00:15:42.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/include/linux/kobject.h	2006-03-04 00:15:55.000000000 +0100
@@ -255,7 +255,7 @@
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-#if defined(CONFIG_HOTPLUG) & defined(CONFIG_NET)
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,

