Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTIPDJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTIPDHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:07:22 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:44416 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261777AbTIPDFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:05:43 -0400
Message-ID: <1063681536.3f667e00ac042@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:05:36 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 9 of 15 -- /fs/super.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/fs/super.c
linux-2.6.0-test4-bk5-mandocs_tweaks/fs/super.c
--- linux-2.6.0-test4-bk5-mandocs/fs/super.c	2003-09-04 10:57:05.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/fs/super.c	2003-09-06
19:42:22.000000000 +1000
@@ -135,8 +135,8 @@
 }
 
 /**
- *	grab_super	- acquire an active reference
- *	@s	- reference we are trying to make active
+ *	grab_super - acquire an active reference
+ *	@s: reference we are trying to make active
  *
  *	Tries to acquire an active reference.  grab_super() is used when we
  * 	had just found a superblock in super_blocks or fs_type->fs_supers
@@ -353,8 +353,8 @@
 }
 
 /**
- *	get_super	-	get the superblock of a device
- *	@dev: device to get the superblock for
+ *	get_super - get the superblock of a device
+ *	@bdev: device to get the superblock for
  *	
  *	Scans the superblock list and finds the superblock of the file system
  *	mounted on the device given. %NULL is returned if no match is found.
@@ -442,10 +442,11 @@
 }
 
 /**
- *	do_remount_sb	-	asks filesystem to change mount options.
+ *	do_remount_sb - asks filesystem to change mount options.
  *	@sb:	superblock in question
  *	@flags:	numeric part of options
  *	@data:	the rest of options
+ *      @force: whether or not to force the change
  *
  *	Alters the mount options of a mounted file system.
  */

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
