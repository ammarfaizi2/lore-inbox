Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKMWUX>; Wed, 13 Nov 2002 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSKMWUX>; Wed, 13 Nov 2002 17:20:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65152 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263333AbSKMWUU>;
	Wed, 13 Nov 2002 17:20:20 -0500
Date: Wed, 13 Nov 2002 14:27:10 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.47] Remove compile warning from scsi/scsi.c
Message-ID: <20021113222709.GB3336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Wed Nov 13 14:09:57 2002
+++ b/drivers/scsi/scsi.c	Wed Nov 13 14:09:57 2002
@@ -1985,7 +1985,7 @@
 	up_read(&scsi_devicelist_mutex);
 	return 0;
 
-fail:
+/* XXX fail: */
 	printk(KERN_ERR "%s: Allocation failure during SCSI scanning, "
 			"some SCSI devices might not be configured\n",
 			__FUNCTION__);
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
