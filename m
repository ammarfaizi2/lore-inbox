Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTBNVM5>; Fri, 14 Feb 2003 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268046AbTBNVLV>; Fri, 14 Feb 2003 16:11:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28938 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267547AbTBNU4b>; Fri, 14 Feb 2003 15:56:31 -0500
Subject: PATCH: new drivers needing mca-legacy for now
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:06:26 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jn2Q-0005hA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/net/depca.c linux-2.5.60-ac1/drivers/net/depca.c
--- linux-2.5.60-ref/drivers/net/depca.c	2003-02-14 21:21:27.000000000 +0000
+++ linux-2.5.60-ac1/drivers/net/depca.c	2003-02-14 19:37:27.000000000 +0000
@@ -252,6 +252,7 @@
 #include <linux/types.h>
 #include <linux/unistd.h>
 #include <linux/ctype.h>
+#include <linux/mca-legacy.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/net/eexpress.c linux-2.5.60-ac1/drivers/net/eexpress.c
--- linux-2.5.60-ref/drivers/net/eexpress.c	2003-02-14 21:21:26.000000000 +0000
+++ linux-2.5.60-ac1/drivers/net/eexpress.c	2003-02-14 19:36:46.000000000 +0000
@@ -114,6 +114,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #include <linux/spinlock.h>
 
 #include <asm/system.h>
