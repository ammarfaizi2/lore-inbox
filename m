Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbWCTWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbWCTWCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWCTWB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:54969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030528AbWCTWBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:12 -0500
Cc: Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/23] Kobject: kobject.h: fix a typo
In-Reply-To: <11428920383371-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920381762-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It shouldn't cause real harm, but it hurts my eyes.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/kobject.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

22f98c0cd7e003b896ee52ded945081307118745
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c374b5f..7ece63f 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -255,7 +255,7 @@ struct subsys_attribute {
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
 extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
 
-#if defined(CONFIG_HOTPLUG) & defined(CONFIG_NET)
+#if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
-- 
1.2.4


