Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUBTTML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUBTTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:11:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:2022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261288AbUBTTG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:29 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039782824@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:18 -0800
Message-Id: <10773039783862@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.4, 2004/02/18 11:40:45-08:00, ambx1@neo.rr.com

[PATCH] PCI: remove unused defines in pci.h

It occured to me that we also have the following related code in pci.h:
Perhaps this should be removed as well?


 include/linux/pci.h |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Feb 20 10:45:09 2004
+++ b/include/linux/pci.h	Fri Feb 20 10:45:09 2004
@@ -362,8 +362,6 @@
 #define PCI_DMA_NONE		3
 
 #define DEVICE_COUNT_COMPATIBLE	4
-#define DEVICE_COUNT_IRQ	2
-#define DEVICE_COUNT_DMA	2
 #define DEVICE_COUNT_RESOURCE	12
 
 /*

