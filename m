Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSJUFek>; Mon, 21 Oct 2002 01:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSJUFek>; Mon, 21 Oct 2002 01:34:40 -0400
Received: from [61.11.79.138] ([61.11.79.138]:29422 "EHLO ks.tachyon.tech")
	by vger.kernel.org with ESMTP id <S264748AbSJUFej>;
	Mon, 21 Oct 2002 01:34:39 -0400
Subject: [PATCH] compile fix for intermezzo fs in 2.4.20pre11
From: K S Sreeram <sreeram@tachyontech.net>
To: alan@redhat.com, braam@clusterfs.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-gl/g89DvSSgOpjKQe+7W"
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2002 11:03:42 +0530
Message-Id: <1035178502.4524.16.camel@ks>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gl/g89DvSSgOpjKQe+7W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

hi 
simple compile fix patch attached for fixing a compile problem in
intermezzo

Regards
Sreeram
Tachyon Technologies



--=-gl/g89DvSSgOpjKQe+7W
Content-Disposition: attachment; filename=intermezzo-compile-fix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=intermezzo-compile-fix.patch; charset=ANSI_X3.4-1968

diff -Nru a/fs/intermezzo/dcache.c b/fs/intermezzo/dcache.c
--- a/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
+++ b/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
@@ -48,7 +48,7 @@
=20
 #include <linux/intermezzo_fs.h>
=20
-static kmem_cache_t * presto_dentry_slab;
+kmem_cache_t * presto_dentry_slab;
=20
 /* called when a cache lookup succeeds */
 static int presto_d_revalidate(struct dentry *de, int flag)

--=-gl/g89DvSSgOpjKQe+7W--

