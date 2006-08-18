Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWHRSwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWHRSwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWHRSwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:52:41 -0400
Received: from ns1.coraid.com ([65.14.39.133]:50021 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932316AbWHRSwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:52:21 -0400
Message-ID: <2d177d34b49206ee39f586543cdecb7a@coraid.com>
Date: Fri, 18 Aug 2006 13:39:02 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [03/13]: remove unused NARGS enum
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

The NARGS enum is left over from older code versions.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c	2006-08-17 16:45:34.000000000 -0400
@@ -15,7 +15,6 @@ enum {
 	MINOR_INTERFACES,
 	MINOR_REVALIDATE,
 	MSGSZ = 2048,
-	NARGS = 10,
 	NMSG = 100,		/* message backlog to retain */
 };
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
