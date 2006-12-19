Return-Path: <linux-kernel-owner+w=401wt.eu-S932871AbWLSSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbWLSSLh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932872AbWLSSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 13:11:37 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:1749 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871AbWLSSLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 13:11:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:in-reply-to:references:content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XKdkU9aZFgrQO92F7oJwX73oC96ekF9KDjPI1dF95fi4blRfBcHGRDI1bL1AJ2PEbWXvWe5GraO29GTLVLU21TPXNq8e7C6E3vmiGFjE5ZvCan88p+mmJUocPNr5SC72XwSUDzbYew7hKwpVZfWAzhnDDNcLYzhccCUOtZGD/ZY=
Subject: [PATCH] Add pci class code for SATA
From: Conke Hu <conke.hu@gmail.com>
Reply-To: conke.hu@gmail.com
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>
References: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>
Content-Type: text/plain
Organization: zju
Date: Wed, 20 Dec 2006 02:11:26 +0800
Message-Id: <1166551886.2977.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci class code 0x0106 for SATA to pci_ids.h

signed-off-by: conke.hu@gmail.com
--------------------
--- linux-2.6.20-rc1/include/linux/pci_ids.h.orig	2006-12-20
01:58:30.000000000 +0800
+++ linux-2.6.20-rc1/include/linux/pci_ids.h	2006-12-20
01:59:07.000000000 +0800
@@ -15,6 +15,7 @@
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102
 #define PCI_CLASS_STORAGE_IPI		0x0103
 #define PCI_CLASS_STORAGE_RAID		0x0104
+#define PCI_CLASS_STORAGE_SATA		0x0106
 #define PCI_CLASS_STORAGE_SAS		0x0107
 #define PCI_CLASS_STORAGE_OTHER		0x0180

