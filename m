Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbTCXQlI>; Mon, 24 Mar 2003 11:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264243AbTCXQel>; Mon, 24 Mar 2003 11:34:41 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:59370 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264267AbTCXQbK>; Mon, 24 Mar 2003 11:31:10 -0500
Message-Id: <200303241642.h2OGgB35008333@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:58 +0000
To: vojtech@suse.cz
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: remove unused var from serio struct
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/serio.h linux-2.5/include/linux/serio.h
--- bk-linus/include/linux/serio.h	2003-03-08 09:57:59.000000000 +0000
+++ linux-2.5/include/linux/serio.h	2003-02-13 22:21:33.000000000 +0000
@@ -25,7 +25,6 @@ struct serio {
 	void *driver;
 	char *name;
 	char *phys;
-	int number;
 
 	unsigned short idbus;
 	unsigned short idvendor;
