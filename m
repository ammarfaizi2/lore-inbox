Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFJSpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTFJSoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:44:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17053 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264023AbTFJSh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:28 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709651938@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651472@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1327, 2003/06/09 15:35:14-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/specialix.c


 drivers/char/specialix.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/specialix.c b/drivers/char/specialix.c
--- a/drivers/char/specialix.c	Tue Jun 10 11:21:50 2003
+++ b/drivers/char/specialix.c	Tue Jun 10 11:21:50 2003
@@ -2294,7 +2294,7 @@
 			found++;
 
 #ifdef CONFIG_PCI
-	if (pci_present()) {
+	{
 		struct pci_dev *pdev = NULL;
 
 		i=0;

