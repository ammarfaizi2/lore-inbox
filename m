Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbSKSSqR>; Tue, 19 Nov 2002 13:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbSKSSoo>; Tue, 19 Nov 2002 13:44:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:16000 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267187AbSKSSoa>;
	Tue, 19 Nov 2002 13:44:30 -0500
Date: Tue, 19 Nov 2002 10:51:30 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove unused label from affs/file.c
Message-ID: <20021119185130.GH1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/fs/affs/file.c b/fs/affs/file.c
--- a/fs/affs/file.c	Tue Nov 19 10:31:17 2002
+++ b/fs/affs/file.c	Tue Nov 19 10:31:17 2002
@@ -391,9 +391,6 @@
 	affs_unlock_ext(inode);
 	return 0;
 
-err_small:
-	affs_error(inode->i_sb,"get_block","Block < 0");
-	return -EIO;
 err_big:
 	affs_error(inode->i_sb,"get_block","strange block request %d", block);
 	return -EIO;


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
