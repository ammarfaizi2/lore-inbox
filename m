Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751849AbWCDMQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbWCDMQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWCDMPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:15:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25616 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751850AbWCDMPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:15:31 -0500
Date: Sat, 4 Mar 2006 13:15:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/kobject.h: fix a typo
Message-ID: <20060304121531.GU9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shouldn't cause real harm, but it hurts my eyes.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm2-full/include/linux/kobject.h.old	2006-03-04 00:15:42.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/include/linux/kobject.h	2006-03-04 00:15:55.000000000 +0100
@@ -255,7 +255,7 @@
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-#if defined(CONFIG_HOTPLUG) & defined(CONFIG_NET)
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,

