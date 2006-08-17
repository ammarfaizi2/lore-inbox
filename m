Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWHQOgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWHQOgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWHQOgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:36:05 -0400
Received: from RedStar.dorchain.net ([212.88.133.153]:16283 "EHLO
	Redstar.dorchain.net") by vger.kernel.org with ESMTP
	id S932199AbWHQOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:36:03 -0400
Message-ID: <11849.158.169.9.14.1155825358.squirrel@www.dorchain.net>
In-Reply-To: <20060817132842.47.NURIpB4835.3636.michal@euridica.enternet.net.pl>
References: <20060817132842.47.NURIpB4835.3636.michal@euridica.enternet.net.pl>
Date: Thu, 17 Aug 2006 16:35:58 +0200 (CEST)
Subject: Re: [RFC][PATCH 47/75] net: drivers/net/wireless/orinoco_tmd.c 
     pci_module_init to pci_register_driver conversion
From: "Joerg Dorchain" <joerg@dorchain.net>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: joerg@dorchain.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-recent-milter: 0 total hits in last 604800 seconds
	digest1 a363891676f67f60444d1cec51c6870e
	digest2 ffdb59d345ac8ca44228978a37f1e473
	digest3 (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

Fine with me.
Signed-off-by: Joerg Dorchain <joerg@dorchain.net>

>
> diff -uprN -X linux-work/Documentation/dontdiff
> linux-work-clean/drivers/net/wireless/orinoco_tmd.c
> linux-work2/drivers/net/wireless/orinoco_tmd.c
> --- linux-work-clean/drivers/net/wireless/orinoco_tmd.c	2006-08-16
> 22:41:00.000000000 +0200
> +++ linux-work2/drivers/net/wireless/orinoco_tmd.c	2006-08-17
> 05:20:37.000000000 +0200
> @@ -228,7 +228,7 @@ MODULE_LICENSE("Dual MPL/GPL");
>  static int __init orinoco_tmd_init(void)
>  {
>  	printk(KERN_DEBUG "%s\n", version);
> -	return pci_module_init(&orinoco_tmd_driver);
> +	return pci_register_driver(&orinoco_tmd_driver);
>  }
>
>  static void __exit orinoco_tmd_exit(void)
>


