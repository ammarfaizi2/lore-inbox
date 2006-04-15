Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWDOBVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWDOBVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 21:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWDOBVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 21:21:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965230AbWDOBVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 21:21:24 -0400
Message-ID: <44404A91.1000302@garzik.org>
Date: Fri, 14 Apr 2006 21:21:21 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] arch/i386/pci/irq.c - new VIA chipsets (fwd)
References: <200604150112.k3F1Cwsa029071@hera.kernel.org>
In-Reply-To: <200604150112.k3F1Cwsa029071@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
> index 3ca59ca..7323544 100644
> --- a/arch/i386/pci/irq.c
> +++ b/arch/i386/pci/irq.c
> @@ -588,7 +588,10 @@ static __init int via_router_probe(struc
>  	case PCI_DEVICE_ID_VIA_82C596:
>  	case PCI_DEVICE_ID_VIA_82C686:
>  	case PCI_DEVICE_ID_VIA_8231:
> +	case PCI_DEVICE_ID_VIA_8233A:
>  	case PCI_DEVICE_ID_VIA_8235:
> +	case PCI_DEVICE_ID_VIA_8237:
> +	case PCI_DEVICE_ID_VIA_8237_SATA:

Why did this get merged with the bogus PCI ID?

	Jeff


