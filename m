Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSJHTk4>; Tue, 8 Oct 2002 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJHTMb>; Tue, 8 Oct 2002 15:12:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24336 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263245AbSJHTGM>; Tue, 8 Oct 2002 15:06:12 -0400
Subject: PATCH: fix ips compile
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:03:19 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzdX-0004uG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/scsi/ips.c linux.2.5.41-ac1/drivers/scsi/ips.c
--- linux.2.5.41/drivers/scsi/ips.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.41-ac1/drivers/scsi/ips.c	2002-10-08 00:10:34.000000000 +0100
@@ -164,7 +164,6 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/reboot.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 
 #include <linux/blk.h>
