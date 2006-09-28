Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWI1HCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWI1HCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWI1HCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:02:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11923 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751622AbWI1HCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:02:44 -0400
Subject: patch sysfs-update-obsolete-comment-in-sysfs_update_file.patch added to gregkh-2.6 tree
To: seto.hidetoshi@jp.fujitsu.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Thu, 28 Sep 2006 00:02:45 -0700
In-Reply-To: <4510F26E.2070706@jp.fujitsu.com>
Message-Id: <20060928070242.9CE698FFEAE@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: sysfs: update obsolete comment in sysfs_update_file

to my gregkh-2.6 tree.  Its filename is

     sysfs-update-obsolete-comment-in-sysfs_update_file.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From seto.hidetoshi@jp.fujitsu.com Wed Sep 20 00:46:42 2006
Message-ID: <4510F26E.2070706@jp.fujitsu.com>
Date: Wed, 20 Sep 2006 16:49:02 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: sysfs: update obsolete comment in sysfs_update_file

And the obsolete comment should be updated (or totally removed).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/sysfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/fs/sysfs/file.c
+++ gregkh-2.6/fs/sysfs/file.c
@@ -502,7 +502,7 @@ int sysfs_update_file(struct kobject * k
 			d_drop(victim);
 		
 		/**
-		 * Drop the reference acquired from sysfs_get_dentry() above.
+		 * Drop the reference acquired from lookup_one_len() above.
 		 */
 		dput(victim);
 	}


Patches currently in gregkh-2.6 which might be from seto.hidetoshi@jp.fujitsu.com are

driver/sysfs-remove-duplicated-dput-in-sysfs_update_file.patch
driver/sysfs-update-obsolete-comment-in-sysfs_update_file.patch
