Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUGUOmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUGUOmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUGUOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:42:12 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:51206 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266500AbUGUOmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:42:01 -0400
Date: Wed, 21 Jul 2004 22:41:39 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Carl Spalletta <cspalletta@yahoo.com>
Message-ID: <Pine.LNX.4.58.0407212238290.1373@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.8, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, RCVD_IN_ORBS, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Here is a patch I received from Carl Spalletta <cspalletta@yahoo.com> 
which removes an unused prototype definition. Please apply.

Signed-off-by: Ian Kent <raven@themaw.net>

diff -ru linux-2.6.7-orig/fs/autofs4/autofs_i.h linux-2.6.7-new/fs/autofs4/autofs_i.h
--- linux-2.6.7-orig/fs/autofs4/autofs_i.h      2004-06-15 22:19:42.000000000 -0700
+++ linux-2.6.7-new/fs/autofs4/autofs_i.h       2004-07-18 08:49:11.000000000 -0700
@@ -138,7 +138,6 @@
 }

 struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
-struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
 void autofs4_free_ino(struct autofs_info *);

 /* Expiration */

