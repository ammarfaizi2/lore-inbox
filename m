Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCEUDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCEUDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCEUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:02:52 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:16645 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261184AbVCETLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 14:11:22 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 29/29] FAT: Fix typo
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87is46q68d.fsf_-_@devron.myhome.or.jp>
	<87ekeuq672.fsf_-_@devron.myhome.or.jp>
	<87acpiq665.fsf_-_@devron.myhome.or.jp>
	<876506q653.fsf_-_@devron.myhome.or.jp>
	<871xauq63z.fsf_-_@devron.myhome.or.jp>
	<87wtsmorii.fsf_-_@devron.myhome.or.jp>
	<87sm3aorho.fsf_-_@devron.myhome.or.jp>
	<87oedyorgu.fsf_-_@devron.myhome.or.jp>
	<87k6olq60a.fsf_-_@devron.myhome.or.jp>
	<87fyz9q5z7.fsf_-_@devron.myhome.or.jp>
	<87br9xq5y8.fsf_-_@devron.myhome.or.jp>
	<877jklq5x7.fsf_-_@devron.myhome.or.jp>
	<873bv9q5vx.fsf_-_@devron.myhome.or.jp>
	<87y8d1orah.fsf_-_@devron.myhome.or.jp>
	<87u0npor9o.fsf_-_@devron.myhome.or.jp>
	<87psydor8t.fsf_-_@devron.myhome.or.jp>
	<87ll91or7y.fsf_-_@devron.myhome.or.jp>
	<87hdjpor76.fsf_-_@devron.myhome.or.jp>
	<87d5udor6b.fsf_-_@devron.myhome.or.jp>
	<878y51or55.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 04:00:02 +0900
In-Reply-To: <878y51or55.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:59:34 +0900")
Message-ID: <874qfpor4d.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a `:'.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/misc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/fat/misc.c~sync08-fat_tweak9 fs/fat/misc.c
--- linux-2.6.11/fs/fat/misc.c~sync08-fat_tweak9	2005-03-06 02:38:03.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/misc.c	2005-03-06 02:38:04.000000000 +0900
@@ -48,7 +48,7 @@ void fat_clusters_flush(struct super_blo
 
 	bh = sb_bread(sb, sbi->fsinfo_sector);
 	if (bh == NULL) {
-		printk(KERN_ERR "FAT bread failed in fat_clusters_flush\n");
+		printk(KERN_ERR "FAT: bread failed in fat_clusters_flush\n");
 		return;
 	}
 
_
