Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278494AbRJPCB5>; Mon, 15 Oct 2001 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278496AbRJPCBl>; Mon, 15 Oct 2001 22:01:41 -0400
Received: from patan.Sun.COM ([192.18.98.43]:32138 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278494AbRJPCBR>;
	Mon, 15 Oct 2001 22:01:17 -0400
Message-ID: <3BCB944F.E5188DDF@sun.com>
Date: Mon, 15 Oct 2001 18:58:39 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: [PATCH] 1 liner to hfs (from asun)
Content-Type: multipart/mixed;
 boundary="------------A6AD9336B3A0DB2429483D97"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A6AD9336B3A0DB2429483D97
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus, Alan,

Attached is a one-liner from Adrian Sun (hfs maintainer).  He asked me to
send it in with this batch of patches.

Please apply.

Thanks

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------A6AD9336B3A0DB2429483D97
Content-Type: text/plain; charset=us-ascii;
 name="hfs-static.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hfs-static.diff"

diff -ruN dist-2.4.12+patches/fs/hfs/catalog.c cvs-2.4.12+patches/fs/hfs/catalog.c
--- dist-2.4.12+patches/fs/hfs/catalog.c	Mon Oct 15 10:23:04 2001
+++ cvs-2.4.12+patches/fs/hfs/catalog.c	Mon Oct 15 10:23:04 2001
@@ -100,7 +100,7 @@
 static LIST_HEAD(entry_unused);
 static struct list_head hash_table[C_HASHSIZE];
 
-spinlock_t entry_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t entry_lock = SPIN_LOCK_UNLOCKED;
 
 static struct {
         int nr_entries;

--------------A6AD9336B3A0DB2429483D97--

