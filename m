Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271709AbTGROFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271469AbTGROEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:04:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21637
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271782AbTGROCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:02:52 -0400
Date: Fri, 18 Jul 2003 15:17:12 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181417.h6IEHCj5017744@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: function is long gone, kill prototype
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/scsi/aha1542.h linux-2.6.0-test1-ac2/drivers/scsi/aha1542.h
--- linux-2.6.0-test1/drivers/scsi/aha1542.h	2003-07-10 21:12:20.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/scsi/aha1542.h	2003-07-14 15:50:01.000000000 +0100
@@ -130,7 +130,6 @@
 };
 
 static int aha1542_detect(Scsi_Host_Template *);
-static int aha1542_command(Scsi_Cmnd *);
 static int aha1542_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
 static int aha1542_abort(Scsi_Cmnd * SCpnt);
 static int aha1542_bus_reset(Scsi_Cmnd * SCpnt);
