Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWEYApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWEYApA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWEYApA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:45:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:62354 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964799AbWEYAo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:44:59 -0400
Message-ID: <4474FE08.50600@garzik.org>
Date: Wed, 24 May 2006 20:44:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/3] avoid pci_find_device
References: <200500919343.119285689fuj@nikdo.nikde.nikam.cz>
In-Reply-To: <200500919343.119285689fuj@nikdo.nikde.nikam.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Hello,
> 
> there are some patches to avoid pci_find_device in drivers, next will come in
> future.
> 
> It's against 2.6.17-rc4-mm3 tree.
> 
> 01-i2c-scx200-acb-use-pci-probing.patch
> 02-bcm43xx-kill-pci-find-device.patch
> 03-gt96100eth-use-pci-probing.patch
> 
>  i2c/busses/scx200_acb.c             |  106 +++++++++++-----------
>  net/gt96100eth.c                    |  167 +++++++++++++++++++++++-------------
>  net/wireless/bcm43xx/bcm43xx_main.c |    3 

Please CC the relevant driver maintainers, and netdev, when you touch 
net drivers.

	Jeff



