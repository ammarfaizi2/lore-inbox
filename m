Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264912AbRFZMxP>; Tue, 26 Jun 2001 08:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264913AbRFZMxF>; Tue, 26 Jun 2001 08:53:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:48367 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264912AbRFZMwu>; Tue, 26 Jun 2001 08:52:50 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Cosmetic JFFS patch.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 13:52:08 +0100
Message-ID: <19708.993559928@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan - Please apply the following self-explanatory patch.

Index: fs/jffs/inode-v23.c
===================================================================
RCS file: /inst/cvs/linux/fs/jffs/Attic/inode-v23.c,v
retrieving revision 1.1.2.11
diff -u -u -r1.1.2.11 inode-v23.c
--- fs/jffs/inode-v23.c	2001/06/02 16:19:32	1.1.2.11
+++ fs/jffs/inode-v23.c	2001/06/26 12:50:36
@@ -1722,6 +1722,12 @@
 	printk("JFFS version "
 	       JFFS_VERSION_STRING
 	       ", (C) 1999, 2000  Axis Communications AB\n");
+	/* LynuxWorks are politely reminded that removing copyright
+	   notices is an offence under the Copyright Design and
+	   Patents Act 1988, and under equivalent non-UK law in
+	   accordance with the Berne Convention. */
+	printk("Portions (C) 2000, 2001 Red Hat, Inc.\n");
+	
 	return register_filesystem(&jffs_fs_type);
 }
 



--
dwmw2


