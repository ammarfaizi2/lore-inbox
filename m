Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUBIXa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUBIX3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:29:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:64956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265438AbUBIXWn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:43 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689413014@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:22 -0800
Message-Id: <10763689422659@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.18, 2004/02/04 14:03:31-08:00, greg@kroah.com

[PATCH] dmapool: Remove sentance in documentation that is now false on 2.6


 Documentation/DMA-API.txt |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
--- a/Documentation/DMA-API.txt	Mon Feb  9 14:58:34 2004
+++ b/Documentation/DMA-API.txt	Mon Feb  9 14:58:34 2004
@@ -131,9 +131,7 @@
 
 The pool destroy() routines free the resources of the pool.  They must be
 called in a context which can sleep.  Make sure you've freed all allocated
-memory back to the pool before you destroy it.  While pci_pool_destroy()
-may not be called in interrupt context, it's perfectly safe to do that with
-dma_pool_destroy().
+memory back to the pool before you destroy it.
 
 
 Part Ic - DMA addressing limitations

