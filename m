Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265438AbSJSBAQ>; Fri, 18 Oct 2002 21:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSJSBAO>; Fri, 18 Oct 2002 21:00:14 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:32154 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265436AbSJSBAM>; Fri, 18 Oct 2002 21:00:12 -0400
Date: Fri, 18 Oct 2002 20:58:38 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.43 : drivers/block/xd.c
Message-ID: <Pine.LNX.4.44.0210182055450.15417-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 The following fixes a 'used but not declared' compile error.  Please review 
for inclusion.

Regards,
Frank

--- linux/drivers/block/xd.c.old	Fri Oct 18 20:51:44 2002
+++ linux/drivers/block/xd.c	Fri Oct 18 20:54:02 2002
@@ -150,6 +150,7 @@
 static int __init xd_init(void)
 {
 	u_char i,controller;
+	u_char count = 0;
 	unsigned int address;
 	int err;
 
 

