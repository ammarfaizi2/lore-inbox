Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWJRURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWJRURs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWJRUQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:21426 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422865AbWJRUJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:44 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/15] aoe: remove sysfs comment
Date: Wed, 18 Oct 2006 13:09:03 -0700
Message-Id: <1161202185862-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021821994-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com> <1161202152750-git-send-email-greg@kroah.com> <11612021563910-git-send-email-greg@kroah.com> <11612021601016-git-send-email-greg@kroah.com> <11612021641240-git-send-email-greg@kroah.com> <11612021682148-git-send-email-greg@kroah.com> <1161202171977-git-send-email-greg@kroah.com> <11612021753859-git-send-email-greg@kroah.com> <1161202179462-git-send-email-greg@kroah.com> <11612021821994-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

Remove unecessary comment.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoeblk.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 196ae7a..088acf4 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -14,7 +14,6 @@ #include "aoe.h"
 
 static kmem_cache_t *buf_pool_cache;
 
-/* add attributes for our block devices in sysfs */
 static ssize_t aoedisk_show_state(struct gendisk * disk, char *page)
 {
 	struct aoedev *d = disk->private_data;
-- 
1.4.2.4

