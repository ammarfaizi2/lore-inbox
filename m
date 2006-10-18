Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422876AbWJRULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbWJRULL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbWJRUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:26346 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422821AbWJRUJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:22 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 6/16] sysfs: update obsolete comment in sysfs_update_file
Date: Wed, 18 Oct 2006 13:08:57 -0700
Message-Id: <1161202163247-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021603361-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

And the obsolete comment should be updated (or totally removed).

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/sysfs/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 93218cc..298303b 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -488,7 +488,7 @@ int sysfs_update_file(struct kobject * k
 			d_drop(victim);
 		
 		/**
-		 * Drop the reference acquired from sysfs_get_dentry() above.
+		 * Drop the reference acquired from lookup_one_len() above.
 		 */
 		dput(victim);
 	}
-- 
1.4.2.4

