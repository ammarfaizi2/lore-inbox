Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGUTlc>; Sun, 21 Jul 2002 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGUTlb>; Sun, 21 Jul 2002 15:41:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313563AbSGUTkf>; Sun, 21 Jul 2002 15:40:35 -0400
Subject: PATCH: 2.5.27 Make the aironet build again
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:07:40 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WMzU-0007YP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header cleanup fallout only

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/net/aironet4500_card.c linux-2.5.27-ac1/drivers/net/aironet4500_card.c
--- linux-2.5.27/drivers/net/aironet4500_card.c	Sat Jul 20 20:11:25 2002
+++ linux-2.5.27-ac1/drivers/net/aironet4500_card.c	Sun Jul 21 16:38:22 2002
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/net/aironet4500_core.c linux-2.5.27-ac1/drivers/net/aironet4500_core.c
--- linux-2.5.27/drivers/net/aironet4500_core.c	Sat Jul 20 20:11:04 2002
+++ linux-2.5.27-ac1/drivers/net/aironet4500_core.c	Sun Jul 21 16:37:52 2002
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/tqueue.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/net/aironet4500_proc.c linux-2.5.27-ac1/drivers/net/aironet4500_proc.c
--- linux-2.5.27/drivers/net/aironet4500_proc.c	Sat Jul 20 20:11:08 2002
+++ linux-2.5.27-ac1/drivers/net/aironet4500_proc.c	Sun Jul 21 16:38:50 2002
@@ -17,6 +17,7 @@
 #include <linux/version.h>
 
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/string.h>
