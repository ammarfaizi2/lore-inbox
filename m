Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030823AbWLAPlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030823AbWLAPlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030896AbWLAPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:41:52 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:36880 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1030823AbWLAPlv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:41:51 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] reiserfs parenthesis fix
Date: Fri, 1 Dec 2006 16:41:26 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011641.27125.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch fixes parenthesis in B_PRIGHT_DELIM_KEY() macro code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 include/linux/reiserfs_fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/include/linux/reiserfs_fs.h	2004-11-17 12:54:22.000000000 +0100
+++ linux-2.4.34-pre6-b/include/linux/reiserfs_fs.h	2006-12-01 11:53:10.000000000 +0100
@@ -787,7 +787,7 @@ struct block_head {       
 
 
 /* Get right delimiting key. -- little endian */
-#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))
+#define B_PRIGHT_DELIM_KEY(p_s_bh)   (&(blk_right_delim_key(B_BLK_HEAD(p_s_bh))))
 
 /* Does the buffer contain a disk leaf. */
 #define B_IS_ITEMS_LEVEL(p_s_bh)     (B_LEVEL(p_s_bh) == DISK_LEAF_NODE_LEVEL)


-- 
Regards,

	Mariusz Kozlowski
