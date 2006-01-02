Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWABQjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWABQjG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWABQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:38:50 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:48475 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750850AbWABQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:38:28 -0500
Message-ID: <43B956CE.8050107@gentoo.org>
Date: Mon, 02 Jan 2006 16:37:34 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Graham Gower <graham.gower@gmail.com>
CC: linux-kernel@vger.kernel.org, prism54-devel@prism54.org
Subject: Re: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in irq
 context
References: <6ec4247d0601020745s2b6a486dg@mail.gmail.com>
In-Reply-To: <6ec4247d0601020745s2b6a486dg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Gower wrote:
> dev_kfree_skb shouldn't be used in an IRQ context.
> 
> Signed-off-by: Graham Gower <graham.gower@gmail.com>
> 
> 
> --- linux/drivers/net/wireless/prism54/islpci_eth.c.orig	2006-01-03
> 01:23:27.000000000 +1030
> +++ linux/drivers/net/wireless/prism54/islpci_eth.c	2006-01-03
> 00:38:46.000000000 +1030

Patch header is linewrapped (patch seems OK though).

You probably want to send this to Jeff Garzik CC'ing the netdev list. I 
didn't get any response from the prism54 developers when I submitted a 
fix for a similar problem in November.

Daniel
