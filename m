Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUFIPbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUFIPbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFIPbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:31:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15512 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266169AbUFIPbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:31:39 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DM 4/5: dm-zero version
Date: Wed, 9 Jun 2004 10:32:23 +0000
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091032.23217.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing dm-zero version number.

From: Alasdair Kergon <agk@redhat.com>
Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-zero.c	2004-06-09 08:47:09.000000000 +0000
+++ source/drivers/md/dm-zero.c	2004-06-09 10:24:52.314139776 +0000
@@ -66,6 +66,7 @@
 
 static struct target_type zero_target = {
 	.name   = "zero",
+	.version = {1, 0, 0},
 	.module = THIS_MODULE,
 	.ctr    = zero_ctr,
 	.map    = zero_map,
