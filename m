Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbUKHHh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUKHHh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKHHh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:37:56 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:61870 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261764AbUKHHhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:37:39 -0500
Date: Mon, 8 Nov 2004 02:37:34 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kernel SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH] Documentation/kernel-parameters.txt: scsi param updates
 [RESEND]
Message-ID: <Pine.LNX.4.61.0411062327150.31630@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates Documentation/kernel-parameters.txt with the proper 
SCSI LUNs params and adds a description for 'max_luns'.

thanks,

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.10-rc1-bk16/Documentation/kernel-parameters.txt	2004-11-06 23:11:03.000000000 -0500
+++ linux-2.6.10-rc1-bk16-1/Documentation/kernel-parameters.txt	2004-11-06 23:21:07.000000000 -0500
@@ -652,9 +652,10 @@
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
 			should make use of
 
-	max_scsi_luns=	[SCSI]
+	max_luns=	[SCSI] Maximum number of LUNs to probe
+			Should be between 1 and 2^32-1.
 
-	max_scsi_report_luns=
+	max_report_luns=
 			[SCSI] Maximum number of LUNs received
 			Should be between 1 and 16384.
 
