Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUELVjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUELVjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUELVjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:39:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61121 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261162AbUELVio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:38:44 -0400
Date: Wed, 12 May 2004 17:38:30 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: fix linux doc errors
Message-ID: <20040512213830.GA24687@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly self explanatory

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/scsi/hosts.c linux-2.6.6/drivers/scsi/hosts.c
--- linux.vanilla-2.6.6/drivers/scsi/hosts.c	2004-05-10 03:31:59.000000000 +0100
+++ linux-2.6.6/drivers/scsi/hosts.c	2004-05-11 20:01:15.000000000 +0100
@@ -345,7 +345,7 @@
 }
 
 /**
- * *scsi_host_get - inc a Scsi_Host ref count
+ * scsi_host_get - inc a Scsi_Host ref count
  * @shost:	Pointer to Scsi_Host to inc.
  **/
 struct Scsi_Host *scsi_host_get(struct Scsi_Host *shost)
@@ -357,7 +357,7 @@
 }
 
 /**
- * *scsi_host_put - dec a Scsi_Host ref count
+ * scsi_host_put - dec a Scsi_Host ref count
  * @shost:	Pointer to Scsi_Host to dec.
  **/
 void scsi_host_put(struct Scsi_Host *shost)
