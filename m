Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVCJBPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVCJBPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVCJBNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:13:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:41631 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262605AbVCJAmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:22 -0500
Cc: arjan@infradead.org
Subject: [PATCH] Kobject: remove some unneeded exports
In-Reply-To: <20050310003403.GA32215@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:38 -0800
Message-Id: <11104148771738@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2035, 2005/03/09 09:31:21-08:00, arjan@infradead.org

[PATCH] Kobject: remove some unneeded exports

kobject_get_path and kobject_rename are only used by the sysfs core code
and not aren't really driver-ish code. Remove the unused exports

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 lib/kobject.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2005-03-09 16:30:23 -08:00
+++ b/lib/kobject.c	2005-03-09 16:30:23 -08:00
@@ -524,7 +524,6 @@
 	}
 }
 
-EXPORT_SYMBOL(kobject_get_path);
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);
@@ -532,7 +531,6 @@
 EXPORT_SYMBOL(kobject_put);
 EXPORT_SYMBOL(kobject_add);
 EXPORT_SYMBOL(kobject_del);
-EXPORT_SYMBOL(kobject_rename);
 
 EXPORT_SYMBOL(kset_register);
 EXPORT_SYMBOL(kset_unregister);

