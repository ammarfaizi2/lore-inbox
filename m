Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTDGXQU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTDGXPh (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64896
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263844AbTDGXJ2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:09:28 -0400
Date: Tue, 8 Apr 2003 01:28:20 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080028.h380SK7K009151@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: junk header removal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/scsi/NCR_D700.c linux-2.5.67-ac1/drivers/scsi/NCR_D700.c
--- linux-2.5.67/drivers/scsi/NCR_D700.c	2003-02-10 18:37:59.000000000 +0000
+++ linux-2.5.67-ac1/drivers/scsi/NCR_D700.c	2003-02-20 16:41:07.000000000 +0000
@@ -95,17 +95,8 @@
 #include <linux/config.h>
 #include <linux/blk.h>
 #include <linux/interrupt.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/spinlock.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/proc_fs.h>
-#include <linux/init.h>
-#include <linux/device.h>
 #include <linux/mca.h>
 
 #include <asm/dma.h>
