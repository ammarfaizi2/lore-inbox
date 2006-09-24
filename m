Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWIXWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWIXWpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWIXWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:45:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46536 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751669AbWIXWp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:45:29 -0400
Date: Sun, 24 Sep 2006 23:45:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missing include (free_irq() use)
Message-ID: <20060924224529.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/aacraid/commsup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

[... and that finishes with build/sparse regressions from up to yesterday
scsi merge]

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 8734a04..19e42ac 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -40,6 +40,7 @@ #include <linux/completion.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/interrupt.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
-- 
1.4.2.GIT
