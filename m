Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWITHqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWITHqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWITHql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:46:41 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18119 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751272AbWITHqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:46:40 -0400
Message-ID: <4510F26E.2070706@jp.fujitsu.com>
Date: Wed, 20 Sep 2006 16:49:02 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.18] sysfs: update obsolete comment in sysfs_update_file
References: <4510EFD8.2050608@jp.fujitsu.com>
In-Reply-To: <4510EFD8.2050608@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the obsolete comment should be updated (or totally removed).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
---
 fs/sysfs/file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18/fs/sysfs/file.c
===================================================================
--- linux-2.6.18.orig/fs/sysfs/file.c
+++ linux-2.6.18/fs/sysfs/file.c
@@ -488,7 +488,7 @@
 			d_drop(victim);
 		
 		/**
-		 * Drop the reference acquired from sysfs_get_dentry() above.
+		 * Drop the reference acquired from lookup_one_len() above.
 		 */
 		dput(victim);
 	}


