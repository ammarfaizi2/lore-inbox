Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSKMWVS>; Wed, 13 Nov 2002 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264010AbSKMWVS>; Wed, 13 Nov 2002 17:21:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:385 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264001AbSKMWVQ>;
	Wed, 13 Nov 2002 17:21:16 -0500
Date: Wed, 13 Nov 2002 14:28:08 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.47] Remove compile time warning from scsi/sd.c
Message-ID: <20021113222808.GC3336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Wed Nov 13 14:09:57 2002
+++ b/drivers/scsi/sd.c	Wed Nov 13 14:09:57 2002
@@ -758,7 +758,6 @@
 sd_spinup_disk(struct scsi_disk *sdkp, char *diskname,
 	       struct scsi_request *SRpnt, unsigned char *buffer) {
 	unsigned char cmd[10];
-	struct scsi_device *sdp = sdkp->device;
 	unsigned long spintime_value = 0;
 	int the_result, retries, spintime;
 
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
