Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWCDCYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWCDCYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 21:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWCDCYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 21:24:55 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5533 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750962AbWCDCYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 21:24:54 -0500
Message-ID: <4408FA6E.3040808@pobox.com>
Date: Fri, 03 Mar 2006 21:24:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] schedule eepro100.c for removal
References: <20060214152226.GK10701@stusta.de>
In-Reply-To: <20060214152226.GK10701@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 4 Feb 2006
> 
>  Documentation/feature-removal-schedule.txt |    6 ++++++
>  drivers/net/eepro100.c                     |    1 +
>  2 files changed, 7 insertions(+)
> 
> --- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old	2006-01-18 08:38:57.000000000 +0100
> +++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt	2006-01-18 08:39:59.000000000 +0100
> @@ -164,0 +165,6 @@
> +---------------------------
> +
> +What:   eepro100 network driver
> +When:   August 2006
> +Why:    replaced by the e100 driver
> +Who:    Adrian Bunk <bunk@stusta.de>

ACK, provided you change the year to 2007


> --- linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c.old	2006-02-03 23:37:55.000000000 +0100
> +++ linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c	2006-02-03 23:39:10.000000000 +0100
> @@ -2391,6 +2391,7 @@ static int __init eepro100_init_module(v
>  #ifdef MODULE
>  	printk(version);
>  #endif
> +	printk(KERN_WARNING "eepro100 will be removed soon, please use the e100 driver\n");
>  	return pci_module_init(&eepro100_driver);

NAK

