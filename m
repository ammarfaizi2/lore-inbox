Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWIJNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWIJNCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWIJNCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:02:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:6545 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750830AbWIJNCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:02:02 -0400
Message-ID: <45040CC7.9080607@garzik.org>
Date: Sun, 10 Sep 2006 09:01:59 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Simon MORIN <simon-morin@laposte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA activation problem on Intel ICH7 82801GBM/GHMA
References: <200609101201.52167.simon-morin@laposte.net>
In-Reply-To: <200609101201.52167.simon-morin@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon MORIN wrote:
> Hello !
> 
> I have installed Gentoo Linux on my Acer Aspire 9410 laptop (Core Duo).
> 
> The hard drive and the cdrom are PATA devices and activating DMA on them seems 
> to be impossible. The IDE controller is an Intel 82801GBM/GHM (ICH7 Family).
> 
> I checked the option "Intel PIIXn chipsets support" (CONFIG_BLK_DEV_PIIX=y) 
> in "ATA/ATAPI/MFM/RLL" but it doesn't recognise the chipset (nothing appear 
> about this in dmesg), so I can only use the generic ide driver. 
> 
> When I run hdparm as root,  it shows me this :
> 
>> hdparm -d1 /dev/sda
> /dev/sda:
>     setting using_dma to 1 (on)
>     HDIO_SET_DMA failed: Invalid argument

Same old combined mode problem.  Google around for this FAQ...

	Jeff



