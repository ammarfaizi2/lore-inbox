Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWHQOR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWHQOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWHQOR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:17:28 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:19925 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932165AbWHQOR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:17:27 -0400
Message-ID: <44E47AC5.8010607@mvista.com>
Date: Thu, 17 Aug 2006 09:18:45 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060714)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: minyard@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 29/75] char: drivers/char/ipmi/ipmi_si_intf.c pci_module_init
 to pci_register_driver conversion
References: <20060817132758.29.IlpbiS4384.3636.michal@euridica.enternet.net.pl>
In-Reply-To: <20060817132758.29.IlpbiS4384.3636.michal@euridica.enternet.net.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please.  Thank you.

-Corey

Michal Piotrowski wrote:
> Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
>
> diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/char/ipmi/ipmi_si_intf.c linux-work2/drivers/char/ipmi/ipmi_si_intf.c
> --- linux-work-clean/drivers/char/ipmi/ipmi_si_intf.c	2006-08-16 22:40:58.000000000 +0200
> +++ linux-work2/drivers/char/ipmi/ipmi_si_intf.c	2006-08-17 05:12:42.000000000 +0200
> @@ -2461,7 +2461,7 @@ static __devinit int init_ipmi_si(void)
>  #endif
>  
>  #ifdef CONFIG_PCI
> -	pci_module_init(&ipmi_pci_driver);
> +	pci_register_driver(&ipmi_pci_driver);
>  #endif
>  
>  	if (si_trydefaults) {
>   

