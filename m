Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVFRUBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVFRUBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 16:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVFRUBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 16:01:05 -0400
Received: from mail.dvmed.net ([216.237.124.58]:26771 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262287AbVFRUAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 16:00:54 -0400
Message-ID: <42B47D5F.8060806@pobox.com>
Date: Sat, 18 Jun 2005 16:00:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikukkon@iki.fi
CC: hch@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12] Fix typo in drivers/pci/pci-driver.c
References: <20050618194956.GA4665@miku.homelinux.net>
In-Reply-To: <20050618194956.GA4665@miku.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Kukkonen wrote:
> The git commit 794f5bfa77955c4455f6d72d8b0e2bee25f1ff0c
> accidentally suffers from a previous typo in that file
> (',' instead of ';' in end of line). Patch included.
> 
> Signed-off-by: Mika Kukkonen (mikukkon@iki.fi)
> 
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c	2005-06-18 22:05:42.642463416 +0300
> +++ linux-2.6/drivers/pci/pci-driver.c	2005-06-18 22:10:37.486761280 +0300
> @@ -396,7 +396,7 @@
>  	/* FIXME, once all of the existing PCI drivers have been fixed to set
>  	 * the pci shutdown function, this test can go away. */
>  	if (!drv->driver.shutdown)
> -		drv->driver.shutdown = pci_device_shutdown,
> +		drv->driver.shutdown = pci_device_shutdown;

Please forward this to stable@kernel.org, too.

	Jeff



