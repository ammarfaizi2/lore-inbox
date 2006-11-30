Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933168AbWK3Jid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbWK3Jid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933340AbWK3Jic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:38:32 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:25105 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S933168AbWK3Jic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:38:32 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: reiserfs-dev@namesys.com
Subject: [PATCH] fs: reiserfs add missing brackets
Date: Thu, 30 Nov 2006 10:38:02 +0100
User-Agent: KMail/1.9.5
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301038.03140.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch adds missing brackets. 

 include/linux/reiserfs_fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/include/linux/reiserfs_fs.h	2006-11-28 12:17:06.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/include/linux/reiserfs_fs.h	2006-11-30 01:05:38.000000000 +0100
@@ -739,7 +739,7 @@ struct block_head {
 #define PUT_B_FREE_SPACE(p_s_bh,val)  do { set_blkh_free_space(B_BLK_HEAD(p_s_bh),val); } while (0)
 
 /* Get right delimiting key. -- little endian */
-#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))
+#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))))
 
 /* Does the buffer contain a disk leaf. */
 #define B_IS_ITEMS_LEVEL(p_s_bh)     (B_LEVEL(p_s_bh) == DISK_LEAF_NODE_LEVEL)


-- 
Regards,

	Mariusz Kozlowski
