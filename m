Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUGRTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUGRTFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUGRTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:05:34 -0400
Received: from web53808.mail.yahoo.com ([206.190.36.203]:54886 "HELO
	web53808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264412AbUGRTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:05:31 -0400
Message-ID: <20040718190531.4719.qmail@web53808.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:05:30 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/hfs* files
To: lkml <linux-kernel@vger.kernel.org>
Cc: zippel@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/hfs/hfs_fs.h linux-2.6.7-new/fs/hfs/hfs_fs.h
--- linux-2.6.7-orig/fs/hfs/hfs_fs.h    2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7-new/fs/hfs/hfs_fs.h     2004-07-18 08:25:40.000000000 -0700
@@ -223,9 +223,6 @@
                      const unsigned char *, unsigned int);
 extern int hfs_compare_dentry(struct dentry *, struct qstr *, struct qstr *);

-/* super.c */
-extern struct super_block *hfs_read_super(struct super_block *,void *,int);
-
 /* trans.c */
 extern void hfs_triv2mac(struct hfs_name *, struct qstr *);
 extern int hfs_mac2triv(char *, const struct hfs_name *);
diff -ru linux-2.6.7-orig/fs/hfsplus/hfsplus_fs.h linux-2.6.7-new/fs/hfsplus/hfsplus_fs.h
--- linux-2.6.7-orig/fs/hfsplus/hfsplus_fs.h    2004-06-15 22:19:52.000000000 -0700
+++ linux-2.6.7-new/fs/hfsplus/hfsplus_fs.h     2004-07-18 08:48:34.000000000 -0700
@@ -344,7 +344,6 @@
 /* options.c */
 int parse_options(char *, struct hfsplus_sb_info *);
 void fill_defaults(struct hfsplus_sb_info *);
-void fill_current(struct hfsplus_sb_info *, struct hfsplus_sb_info *);

 /* tables.c */
 extern u16 case_fold_table[];

