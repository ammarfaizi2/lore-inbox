Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUJBRy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUJBRy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUJBRy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:54:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:40137 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267438AbUJBRyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:54:23 -0400
Date: Sat, 2 Oct 2004 19:54:21 +0200
From: Olaf Hering <olh@suse.de>
To: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] remove scsi ioctl from udf/lowlevel.c
Message-ID: <20041002175421.GA15836@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure why these defines and typedefs exists, the driver compiles
fine without it.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9-rc3-bk2/fs/udf/lowlevel.c linux-2.6.9-rc3-bk2.udf/fs/udf/lowlevel.c
--- linux-2.6.9-rc3-bk2/fs/udf/lowlevel.c	2004-09-30 05:04:59.000000000 +0200
+++ linux-2.6.9-rc3-bk2.udf/fs/udf/lowlevel.c	2004-10-02 19:51:02.046516355 +0200
@@ -27,12 +27,6 @@
 #include <linux/blkdev.h>
 #include <linux/cdrom.h>
 #include <asm/uaccess.h>
-#include <scsi/scsi.h>
-
-typedef struct scsi_device Scsi_Device;
-typedef struct scsi_cmnd   Scsi_Cmnd;
-
-#include <scsi/scsi_ioctl.h>
 
 #include <linux/udf_fs.h>
 #include "udf_sb.h"

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
