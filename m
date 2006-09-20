Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWITSxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWITSxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWITSxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:53:06 -0400
Received: from ns1.coraid.com ([65.14.39.133]:41592 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932252AbWITSwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:52:38 -0400
Message-ID: <61bb24a65dfbaf366fa9b7fff57834b9@coraid.com>
Date: Wed, 20 Sep 2006 14:36:48 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [03/14]: remove unused NARGS enum
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NARGS enum is left over from older code versions.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoechr.c	2006-09-20 14:29:35.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoechr.c	2006-09-20 14:29:35.000000000 -0400
@@ -15,7 +15,6 @@ enum {
 	MINOR_INTERFACES,
 	MINOR_REVALIDATE,
 	MSGSZ = 2048,
-	NARGS = 10,
 	NMSG = 100,		/* message backlog to retain */
 };
 


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
