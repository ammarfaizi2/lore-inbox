Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBFEHN>; Wed, 5 Feb 2003 23:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTBFEGk>; Wed, 5 Feb 2003 23:06:40 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60944 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265470AbTBFEDA>;
	Wed, 5 Feb 2003 23:03:00 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044932196@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044942883@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.970, 2003/02/06 14:49:36+11:00, greg@kroah.com

sysfs: remember to add EXPORT_SYMBOL() for sysfs_update_file.


diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Thu Feb  6 14:51:01 2003
+++ b/fs/sysfs/inode.c	Thu Feb  6 14:51:01 2003
@@ -855,6 +855,7 @@
 }
 
 EXPORT_SYMBOL(sysfs_create_file);
+EXPORT_SYMBOL(sysfs_update_file);
 EXPORT_SYMBOL(sysfs_remove_file);
 EXPORT_SYMBOL(sysfs_create_link);
 EXPORT_SYMBOL(sysfs_remove_link);

