Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTBKKvB>; Tue, 11 Feb 2003 05:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTBKKvA>; Tue, 11 Feb 2003 05:51:00 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267544AbTBKKuv>;
	Tue, 11 Feb 2003 05:50:51 -0500
Date: Mon, 10 Feb 2003 18:13:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Kill "testing by UNISYS" message
Message-ID: <20030210171336.GA10875@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills totally unneccessary and long-obsolete message about
testing by UNIFIX and similar obsolete message about NET4.0 for
linux2.4... Please apply,
								Pavel

--- clean/init/main.c	2003-01-17 23:13:40.000000000 +0100
+++ linux/init/main.c	2003-01-17 23:19:36.000000000 +0100
@@ -436,7 +436,6 @@
 	ipc_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 
--- clean/net/socket.c	2003-01-09 22:16:36.000000000 +0100
+++ linux/net/socket.c	2003-01-09 22:20:00.000000000 +0100
@@ -1784,9 +1784,6 @@
 {
 	int i;
 
-	printk(KERN_INFO "Linux NET4.0 for Linux 2.4\n");
-	printk(KERN_INFO "Based upon Swansea University Computer Society NET3.039\n");
-
 	/*
 	 *	Initialize all address (protocol) families. 
 	 */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
