Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSGUTjS>; Sun, 21 Jul 2002 15:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSGUTjS>; Sun, 21 Jul 2002 15:39:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27665 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313421AbSGUTi3>; Sun, 21 Jul 2002 15:38:29 -0400
Subject: PATCH: 2.5.27 correct headers so miropcm-rds builds
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:05:49 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WMxh-0007Y3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/media/radio/miropcm20-rds-core.c linux-2.5.27-ac1/drivers/media/radio/miropcm20-rds-core.c
--- linux-2.5.27/drivers/media/radio/miropcm20-rds-core.c	Sat Jul 20 20:12:19 2002
+++ linux-2.5.27-ac1/drivers/media/radio/miropcm20-rds-core.c	Sun Jul 21 15:39:49 2002
@@ -15,8 +15,9 @@
 
 #define _NO_VERSION_
 
-/* #include <linux/kernel.h> */
 #include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/semaphore.h>
