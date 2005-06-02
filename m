Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVFBH6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVFBH6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFBH6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:58:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47558 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261172AbVFBH6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:00 -0400
Date: Thu, 2 Jun 2005 16:02:22 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/9] dlm: export with gpl
Message-ID: <20050602080222.GA21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="export-with-gpl.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/main.c
===================================================================
--- linux.orig/drivers/dlm/main.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/main.c	2005-06-02 12:43:52.480503992 +0800
@@ -96,8 +96,8 @@
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(dlm_new_lockspace);
-EXPORT_SYMBOL(dlm_release_lockspace);
-EXPORT_SYMBOL(dlm_lock);
-EXPORT_SYMBOL(dlm_unlock);
+EXPORT_SYMBOL_GPL(dlm_new_lockspace);
+EXPORT_SYMBOL_GPL(dlm_release_lockspace);
+EXPORT_SYMBOL_GPL(dlm_lock);
+EXPORT_SYMBOL_GPL(dlm_unlock);
 

--

