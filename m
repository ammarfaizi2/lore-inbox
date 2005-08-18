Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVHRGUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVHRGUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVHRGUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:20:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23707 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750827AbVHRGUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:20:30 -0400
Date: Thu, 18 Aug 2005 14:26:02 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mark.fasheh@oracle.com
Subject: [PATCH] configfs: export config_group_find_obj
Message-ID: <20050818062602.GD10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the dlm I use config_group_find_obj() which isn't exported.

Signed-off-by: David Teigland <teigland@redhat.com>

diff -urpN a/fs/configfs/item.c b/fs/configfs/item.c
--- a/fs/configfs/item.c	2005-08-17 17:19:23.000000000 +0800
+++ b/fs/configfs/item.c	2005-08-18 14:15:51.681973168 +0800
@@ -224,4 +224,5 @@ EXPORT_SYMBOL(config_item_init);
 EXPORT_SYMBOL(config_group_init);
 EXPORT_SYMBOL(config_item_get);
 EXPORT_SYMBOL(config_item_put);
+EXPORT_SYMBOL(config_group_find_obj);
 
