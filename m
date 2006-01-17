Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWAQUGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWAQUGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWAQUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:06:38 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:4984 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964793AbWAQUGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:06:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sEPWAUTIcOiWDepPvl5mmu9tz8U/Aon6PVxP0f1xWmVqS65u9Rbii/qO1y0Dn6j3ZQIr4LEyHrGiNvRIx5FlzIUCbpKu7A+TAGrXGgbf4vAG4DBq7RJ+GGcN/WwOyx9NLb1djrqfpRUXdgWXyU3Fp/vZ55vkngAzByRqU1eayKc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: [PATCH] add a few missing spaces to MODULE_PARM_DESC() text for qla2xxx
Date: Tue, 17 Jan 2006 21:06:42 +0100
User-Agent: KMail/1.9
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172106.42640.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a few spaces to MODULE_PARM_DESC() text for qla2xxx. Without these 
spaces text runs together when modinfo prints the text.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/qla_os.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc1-orig/drivers/scsi/qla2xxx/qla_os.c	2006-01-17 19:14:07.000000000 +0100
+++ linux-2.6.16-rc1/drivers/scsi/qla2xxx/qla_os.c	2006-01-17 21:01:17.000000000 +0100
@@ -39,14 +39,14 @@
 int qlport_down_retry = 30;
 module_param(qlport_down_retry, int, S_IRUGO|S_IRUSR);
 MODULE_PARM_DESC(qlport_down_retry,
-		"Maximum number of command retries to a port that returns"
+		"Maximum number of command retries to a port that returns "
 		"a PORT-DOWN status.");
 
 int ql2xplogiabsentdevice;
 module_param(ql2xplogiabsentdevice, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(ql2xplogiabsentdevice,
 		"Option to enable PLOGI to devices that are not present after "
-		"a Fabric scan.  This is needed for several broken switches."
+		"a Fabric scan.  This is needed for several broken switches. "
 		"Default is 0 - no PLOGI. 1 - perfom PLOGI.");
 
 int ql2xloginretrycount = 0;
@@ -74,7 +74,7 @@
 int ql2xprocessrscn;
 module_param(ql2xprocessrscn, int, S_IRUGO|S_IRUSR);
 MODULE_PARM_DESC(ql2xprocessrscn,
-		"Option to enable port RSCN handling via a series of less"
+		"Option to enable port RSCN handling via a series of less "
 		"fabric intrusive ADISCs and PLOGIs.");
 
 /*
