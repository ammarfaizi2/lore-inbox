Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTFJVPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTFJVC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:02:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:9135 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263898AbTFJShP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:15 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709643664@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709641395@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1323, 2003/06/09 15:32:51-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/isicom.c


 drivers/char/isicom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c	Tue Jun 10 11:22:08 2003
+++ b/drivers/char/isicom.c	Tue Jun 10 11:22:08 2003
@@ -1905,7 +1905,7 @@
 		}
 	}	
 	
-	if (pci_present() && (card < BOARD_COUNT)) {
+	if (card < BOARD_COUNT) {
 		for (idx=0; idx < DEVID_COUNT; idx++) {
 			dev = NULL;
 			for (;;){

