Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbTDTSSA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTDTSSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:18:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:28601 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263653AbTDTSR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:17:59 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:29:58 +0200 (MEST)
Message-Id: <UTC200304201829.h3KITwt18108.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] compilation fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all gotos to this label have been commented out,
the label itself should be commented out as well.

diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
--- a/fs/nfs/nfs4xdr.c	Sun Apr 20 12:59:32 2003
+++ b/fs/nfs/nfs4xdr.c	Sun Apr 20 19:58:15 2003
@@ -361,7 +361,7 @@
 	*q++ = htonl(len);
 
 	status = 0;
-out:
+/* out: */
 	return status;
 }
 
