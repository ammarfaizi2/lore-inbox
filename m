Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277656AbRJZGIk>; Fri, 26 Oct 2001 02:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277797AbRJZGIc>; Fri, 26 Oct 2001 02:08:32 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:56894 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277656AbRJZGIT>; Fri, 26 Oct 2001 02:08:19 -0400
Date: Fri, 26 Oct 2001 01:08:48 -0500
Message-Id: <200110260608.BAA18069@mandrakesoft.mandrakesoft.com>
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: PATCH 2.4.14.2: build fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix typos which break the 2.4.14-pre2 build..


diff -Naur -X /home/jgarzik/lib/dontdiff /home/jgarzik/tmp/linux-2.4.14-pre2/drivers/block/nbd.c linux_2_4/drivers/block/nbd.c
--- /home/jgarzik/tmp/linux-2.4.14-pre2/drivers/block/nbd.c	Fri Oct 26 03:56:02 2001
+++ linux_2_4/drivers/block/nbd.c	Fri Oct 26 05:15:07 2001
@@ -471,7 +471,7 @@
 
 static struct block_device_operations nbd_fops =
 {
-	owner:		THIS_MODULE.
+	owner:		THIS_MODULE,
 	open:		nbd_open,
 	release:	nbd_release,
 	ioctl:		nbd_ioctl,
diff -Naur -X /home/jgarzik/lib/dontdiff /home/jgarzik/tmp/linux-2.4.14-pre2/drivers/block/paride/pcd.c linux_2_4/drivers/block/paride/pcd.c
--- /home/jgarzik/tmp/linux-2.4.14-pre2/drivers/block/paride/pcd.c	Fri Oct 26 03:56:02 2001
+++ linux_2_4/drivers/block/paride/pcd.c	Fri Oct 26 05:20:43 2001
@@ -271,7 +271,7 @@
 	release:		cdrom_release,
 	ioctl:			cdrom_ioctl,
 	check_media_change:	cdrom_media_changed,
-}
+};
 
 static struct cdrom_device_ops pcd_dops = {
 	pcd_open,
