Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUBIXea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUBIXc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:32:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:20671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265444AbUBIX2w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:28:52 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.3-rc1
In-Reply-To: <10763691403705@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:25:41 -0800
Message-Id: <10763691411688@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.19.2, 2004/02/02 15:40:06-08:00, eugene.teo@eugeneteo.net

[PATCH] Kobject: export some missing symbols


 lib/kobject.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Mon Feb  9 15:09:09 2004
+++ b/lib/kobject.c	Mon Feb  9 15:09:09 2004
@@ -630,6 +630,9 @@
 EXPORT_SYMBOL(kobject_unregister);
 EXPORT_SYMBOL(kobject_get);
 EXPORT_SYMBOL(kobject_put);
+EXPORT_SYMBOL(kobject_add);
+EXPORT_SYMBOL(kobject_del);
+EXPORT_SYMBOL(kobject_rename);
 EXPORT_SYMBOL(kobject_hotplug);
 
 EXPORT_SYMBOL(kset_register);

