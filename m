Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFAUVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFAUVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFAUVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:21:20 -0400
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:24698 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261187AbVFAUKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:10:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=uy8kIHeA+HpSysyleU7fBM5MITSFPSdXV0C5idnZee8u5KbiSz8usu+NKYS+uCIDPzK8MCXL/57kDj681j+t+MBcqwPNFcXH3K71pttuw/P9efIhZu6g5inzCM/zMpIX68dh/XJYAthUZRk4dWVWsSWcNNBKaCDPDeD2U0jQNos=  ;
Message-ID: <429E1616.5040107@yahoo.com>
Date: Wed, 01 Jun 2005 13:09:58 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE 5/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator:
 iscsi-Makefile.patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	iscsi-Makefile.patch - drivers/scsi/Makefile changes.

	Signed-off-by: Alex Aizman <itn780@yahoo.com>
	Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
	Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Index: drivers/scsi/Makefile
===================================================================
--- 7570fde464d579ce455c865f07a613e967e9396c/drivers/scsi/Makefile  (mode:100644 sha1:9cb9fe7d623aeda983c2e6b2f4cb57bdca796673)
+++ uncommitted/drivers/scsi/Makefile  (mode:100644)
@@ -30,6 +30,7 @@
 obj-$(CONFIG_SCSI_FC_ATTRS) 	+= scsi_transport_fc.o
 obj-$(CONFIG_SCSI_ISCSI_ATTRS)	+= scsi_transport_iscsi.o
 
+obj-$(CONFIG_ISCSI_TCP) 	+= iscsi_tcp.o
 obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
 obj-$(CONFIG_A3000_SCSI)	+= a3000.o	wd33c93.o
 obj-$(CONFIG_A2091_SCSI)	+= a2091.o	wd33c93.o



