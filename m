Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTIJCNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTIJCNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:13:37 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:15626 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S264239AbTIJCNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:13:36 -0400
Message-ID: <3F5E884A.E62D27EE@compuserve.com>
Date: Tue, 09 Sep 2003 22:11:22 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.6.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
CC: Joe@perches.com
Subject: Re: [PATCH] 2.6.0-test4 SEQ_START_TOKEN net/* (2/6)
Content-Type: multipart/mixed;
 boundary="------------49A81D5250D4DF80A629C1DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------49A81D5250D4DF80A629C1DE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch to net/appletalk/aarp.c seemed fine, however it seems it
changed prior to hitting the bk tree.  The attached is needed to
compile.

-- 
Kevin
--------------49A81D5250D4DF80A629C1DE
Content-Type: text/plain; charset=us-ascii;
 name="patch_aarp_bk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_aarp_bk.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1238  -> 1.1239 
#	net/appletalk/aarp.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/09	cobra@sea.kevb.net	1.1239
# Fixup typo
# --------------------------------------------
#
diff -Nru a/net/appletalk/aarp.c b/net/appletalk/aarp.c
--- a/net/appletalk/aarp.c	Tue Sep  9 22:05:25 2003
+++ b/net/appletalk/aarp.c	Tue Sep  9 22:05:25 2003
@@ -941,7 +941,7 @@
 	iter->table     = resolved;
 	iter->bucket    = 0;
 
-	return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN);
+	return *pos ? iter_next(iter, pos) : SEQ_START_TOKEN;
 }
 
 static void *aarp_seq_next(struct seq_file *seq, void *v, loff_t *pos)

--------------49A81D5250D4DF80A629C1DE--

