Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVFKUUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVFKUUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFKUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:20:29 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56582 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261817AbVFKUTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:19:40 -0400
Date: Sat, 11 Jun 2005 22:19:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Erich Chen <erich@areca.com.tw>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] drivers/scsi/arcmsr/arcmsr.c: remove unneeded #include <linux/devfs_fs_kernel.h>
Message-ID: <20050611201938.GN3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unneeded #include.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc6-mm1-full/drivers/scsi/arcmsr/arcmsr.c.old	2005-06-11 20:58:49.000000000 +0200
+++ linux-2.6.12-rc6-mm1-full/drivers/scsi/arcmsr/arcmsr.c	2005-06-11 20:58:56.000000000 +0200
@@ -101,7 +101,6 @@
 #include <linux/moduleparam.h>
 #include <linux/blkdev.h>
 #include <linux/timer.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/mc146818rtc.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>

