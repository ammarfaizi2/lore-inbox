Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265050AbSJWPZk>; Wed, 23 Oct 2002 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSJWPZk>; Wed, 23 Oct 2002 11:25:40 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:16655 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265050AbSJWPZj>; Wed, 23 Oct 2002 11:25:39 -0400
Date: Wed, 23 Oct 2002 09:27:57 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/10] 2.5.44 cciss rm unuxed variable
Message-ID: <20021023092757.C14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 3 of 10
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44

DESC
Remove unused variable from cciss_scsi.c


 drivers/block/cciss_scsi.c |    1 -
 1 files changed, 1 deletion

--- linux-2.5.44/drivers/block/cciss_scsi.c~rm_unused_var	Mon Oct 21 12:05:43 2002
+++ linux-2.5.44-root/drivers/block/cciss_scsi.c	Mon Oct 21 12:05:43 2002
@@ -1262,7 +1262,6 @@ cciss_scsi_proc_info(char *buffer, /* da
 
 	int buflen, datalen;
 	struct Scsi_Host *sh;
-	int found;
 	ctlr_info_t *ci;
 	int cntl_num;
 

.
