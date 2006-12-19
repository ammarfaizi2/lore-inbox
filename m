Return-Path: <linux-kernel-owner+w=401wt.eu-S932899AbWLSTc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbWLSTc5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWLSTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:32:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55183 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbWLSTc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:32:56 -0500
Message-ID: <45883E64.20400@garzik.org>
Date: Tue, 19 Dec 2006 14:32:52 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: conke.hu@gmail.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add pci class code for SATA
References: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain> <1166551886.2977.5.camel@localhost.localdomain>
In-Reply-To: <1166551886.2977.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Conke Hu wrote:
> Add pci class code 0x0106 for SATA to pci_ids.h
> 
> signed-off-by: conke.hu@gmail.com
> --------------------
> --- linux-2.6.20-rc1/include/linux/pci_ids.h.orig	2006-12-20
> 01:58:30.000000000 +0800
> +++ linux-2.6.20-rc1/include/linux/pci_ids.h	2006-12-20
> 01:59:07.000000000 +0800
> @@ -15,6 +15,7 @@
>  #define PCI_CLASS_STORAGE_FLOPPY	0x0102
>  #define PCI_CLASS_STORAGE_IPI		0x0103
>  #define PCI_CLASS_STORAGE_RAID		0x0104
> +#define PCI_CLASS_STORAGE_SATA		0x0106
>  #define PCI_CLASS_STORAGE_SAS		0x0107
>  #define PCI_CLASS_STORAGE_OTHER		0x0180

Two comments:

1) I think "_SATA" is an inaccurate description.  It should be _AHCI AFAICS.

2) Typically we don't add constants unless they are used somewhere...

	Jeff



