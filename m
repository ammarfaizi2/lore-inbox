Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUJaBHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUJaBHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUJaBHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:07:41 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:28382 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261455AbUJaBHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:07:39 -0400
Date: Sat, 30 Oct 2004 21:07:34 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trivial@rustcorp.com.au
Subject: [PATCH] [Trivial] Documentation/kernel-parameters.txt: scsi param
 updates
Message-ID: <Pine.LNX.4.61.0410302057480.31387@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch updates a couple scsi params in 
Documentation/kernel-parameters.txt.

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.10-rc1-bk9/Documentation/kernel-parameters.txt	2004-10-30 19:10:16.000000000 -0400
+++ linux-2.6.10-rc1-bk9-4/Documentation/kernel-parameters.txt	2004-10-30 20:53:18.000000000 -0400
@@ -652,9 +652,9 @@
 	maxcpus=	[SMP] Maximum number of processors that	an SMP kernel
 			should make use of
 
-	max_scsi_luns=	[SCSI]
+	max_luns=	[SCSI] Maximum number of LUNs to probe
 
-	max_scsi_report_luns=
+	max_report_luns=
 			[SCSI] Maximum number of LUNs received
 			Should be between 1 and 16384.
 
