Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286140AbRLZDlm>; Tue, 25 Dec 2001 22:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286145AbRLZDld>; Tue, 25 Dec 2001 22:41:33 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53769 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286140AbRLZDlT>;
	Tue, 25 Dec 2001 22:41:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@math.psu.edu>
Subject: 2.5.2-pre2 forces ramfs on
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Dec 2001 14:41:02 +1100
Message-ID: <2452.1009338062@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: 2-pre1.1/fs/Config.in
--- 2-pre1.1/fs/Config.in Sat, 24 Nov 2001 05:28:08 +1100 kaos (linux-2.5/F/d/27_Config.in 1.1 644)
+++ 2-pre2.1/fs/Config.in Wed, 26 Dec 2001 14:32:39 +1100 kaos (linux-2.5/F/d/27_Config.in 1.2 644)
@@ -45,7 +45,7 @@ if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFI
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
 bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
-tristate 'Simple RAM-based file system support' CONFIG_RAMFS
+define_bool CONFIG_RAMFS y

Why is ramfs forced on?

And why is Al Viro's email address not in CREDITS or MAINTAINERS?  We
should have somewhere to complain to ;).

