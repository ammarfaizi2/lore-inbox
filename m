Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWBXUrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWBXUrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWBXUrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:47:11 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:45269 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751100AbWBXUrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:47:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=Mrzdx3hbQQzJjOdZ+zdHdcHezJU2V2bBbiIkQw1IQlTJ5DkmYZlkUHrrTqyOk+uaU1szPEtLqe0V5nb8GfKc6PNbi4OpMU556QsY5txtnm+ePSmDm/HKa5GTYn9AaCrTvOAnGclJ0sXEOpAxvxt4HBK4pwOW46fcYPn/SZPlSpE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 03/13] small whitespace cleanup for qlogic driver
Date: Fri, 24 Feb 2006 21:47:23 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, andrew.vasquez@qlogic.com,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242147.23648.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a few spaces to MODULE_PARM_DESC() text for qla2xxx. Without these
spaces text runs together when modinfo prints the text.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/qla2xxx/qla_os.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/drivers/scsi/qla2xxx/qla_os.c	2006-02-24 19:25:38.000000000 +0100
+++ linux-2.6.16-rc4-mm2/drivers/scsi/qla2xxx/qla_os.c	2006-02-24 20:29:45.000000000 +0100
@@ -39,14 +39,14 @@ MODULE_PARM_DESC(ql2xlogintimeout,
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
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(ql2xfdmienable,
 int ql2xprocessrscn;
 module_param(ql2xprocessrscn, int, S_IRUGO|S_IRUSR);
 MODULE_PARM_DESC(ql2xprocessrscn,
-		"Option to enable port RSCN handling via a series of less"
+		"Option to enable port RSCN handling via a series of less "
 		"fabric intrusive ADISCs and PLOGIs.");
 
 /*



