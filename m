Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSIOQX1>; Sun, 15 Sep 2002 12:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSIOQX0>; Sun, 15 Sep 2002 12:23:26 -0400
Received: from smtpout.mac.com ([204.179.120.97]:5098 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S318080AbSIOQX0>;
	Sun, 15 Sep 2002 12:23:26 -0400
Date: Sun, 15 Sep 2002 18:27:53 +0200
Subject: [PATCH] 2.4.20-pre7: export proc_get_inode
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: marcelo@conectiva.com.br
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <15532699-C8C8-11D6-B517-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a patch against 2.4.20-pre7 to export proc_get_inode(). This is
needed to compile and load the wlan/comx driver as a module

--- linux/fs/proc/root.c.orig	Tue Sep 10 20:54:30 2002
+++ linux/fs/proc/root.c	Sun Sep 15 15:01:01 2002
@@ -145,3 +145,4 @@
  EXPORT_SYMBOL(proc_net);
  EXPORT_SYMBOL(proc_bus);
  EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

