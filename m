Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRBFQhF>; Tue, 6 Feb 2001 11:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129320AbRBFQgq>; Tue, 6 Feb 2001 11:36:46 -0500
Received: from knatte.tninet.se ([195.100.94.10]:59087 "HELO knatte.tninet.se")
	by vger.kernel.org with SMTP id <S129214AbRBFQge>;
	Tue, 6 Feb 2001 11:36:34 -0500
Date: Tue, 6 Feb 2001 14:59:40 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in linux/fs/reiserfs/namei.c
Message-ID: <20010206145940.B3245@sm.luth.se>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch fixes a typo in linux/fs/reiserfs/namei.c.
It is against 2.4.1-ac3.

--- linux-2.4.1-ac3/fs/reiserfs/namei.c~	Tue Feb  6 14:58:08 2001
+++ linux-2.4.1-ac3/fs/reiserfs/namei.c	Tue Feb  6 14:58:26 2001
@@ -1213,7 +1213,7 @@
     // anybody, but it will panic if will not be able to find the
     // entry. This needs one more clean up
     if (reiserfs_cut_from_item (&th, &old_entry_path, &(old_de.de_entry_key), old_dir, NULL, 0) < 0)
-	reiserfs_warning ("vs-: reiserfs_rename: coudl not cut old name. Fsck later?\n");
+	reiserfs_warning ("vs-: reiserfs_rename: could not cut old name. Fsck later?\n");
 
     old_dir->i_size -= DEH_SIZE + old_de.de_entrylen;
     old_dir->i_blocks = ((old_dir->i_size + 511) >> 9);
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
