Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWIYWUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWIYWUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbWIYWUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:20:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751531AbWIYWUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:20:19 -0400
Subject: [PATCH] aacraid: fix warning caused by missing include
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:45:04 +0100
Message-Id: <1159224304.11049.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/scsi/aacraid/commsup.c linux-2.6.18-mm1/drivers/scsi/aacraid/commsup.c
--- linux.vanilla-2.6.18-mm1/drivers/scsi/aacraid/commsup.c	2006-09-25 12:10:16.000000000 +0100
+++ linux-2.6.18-mm1/drivers/scsi/aacraid/commsup.c	2006-09-25 12:24:03.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/interrupt.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>

