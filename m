Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTJTXXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTJTXXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:23:17 -0400
Received: from panda.sul.com.br ([200.219.150.4]:20491 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262982AbTJTXXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:23:16 -0400
Date: Mon, 20 Oct 2003 21:22:01 -0200
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <mikenc@us.ibm.com>
Subject: [patch] qlogic: don't use qinfo as name
Message-ID: <20031020232200.GA473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	these are the patches modified based on comments sent by Jeff,
Christoph and Mike.

-- 
aris


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="qlogic-dont_use_qinfo.patch"

--- linux/drivers/scsi/qlogicfas.c.orig	2003-10-17 16:47:54.000000000 -0200
+++ linux/drivers/scsi/qlogicfas.c	2003-10-17 16:48:30.000000000 -0200
@@ -665,7 +665,6 @@
 	sprintf(qinfo,
 		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
 		qltyp, qbase, qlirq, QL_TURBO_PDMA);
-	host->name = qinfo;
 
 	return hreg;
 

--sdtB3X0nJg68CQEu--
