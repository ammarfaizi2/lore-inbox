Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUGRTNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUGRTNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGRTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:13:04 -0400
Received: from web53810.mail.yahoo.com ([206.190.36.205]:64951 "HELO
	web53810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263980AbUGRTNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:13:01 -0400
Message-ID: <20040718191301.7447.qmail@web53810.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:13:01 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/udf files
To: lkml <linux-kernel@vger.kernel.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux_udf@hpesjro.fc.hp.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/udf/udfdecl.h linux-2.6.7-new/fs/udf/udfdecl.h
--- linux-2.6.7-orig/fs/udf/udfdecl.h   2004-06-15 22:19:22.000000000 -0700
+++ linux-2.6.7-new/fs/udf/udfdecl.h    2004-07-18 08:32:54.000000000 -0700
@@ -111,7 +111,6 @@
 extern int8_t udf_current_aext(struct inode *, lb_addr *, int *, lb_addr *, uint32_t *, struct
buffer_head **, int);

 /* misc.c */
-extern int udf_read_tagged_data(char *, int size, int fd, int block, int partref);
 extern struct buffer_head *udf_tgetblk(struct super_block *, int);
 extern struct buffer_head *udf_tread(struct super_block *, int);
 extern struct genericFormat *udf_add_extendedattr(struct inode *, uint32_t, uint32_t, uint8_t);
@@ -163,7 +162,6 @@
 extern extent_ad * udf_get_fileextent(void * buffer, int bufsize, int * offset);
 extern long_ad * udf_get_filelongad(uint8_t *, int, int *, int);
 extern short_ad * udf_get_fileshortad(uint8_t *, int, int *, int);
-extern uint8_t * udf_get_filead(struct fileEntry *, uint8_t *, int, int, int, int *);

 /* crc.c */
 extern uint16_t udf_crc(uint8_t *, uint32_t, uint16_t);

