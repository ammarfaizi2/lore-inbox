Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWACNMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWACNMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWACNMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:12:20 -0500
Received: from stinky.trash.net ([213.144.137.162]:65442 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751395AbWACNMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:12:19 -0500
Message-ID: <43BA7810.6010308@trash.net>
Date: Tue, 03 Jan 2006 14:11:44 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Graham Gower <graham.gower@gmail.com>
CC: Roger While <simrw@sim-basis.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] prism54/islpci_eth.c: dev_kfree_skb in irq
 context
References: <6.1.1.1.2.20060103105620.02c523e0@192.168.6.12> <6ec4247d0601030419w377fd396x@mail.gmail.com>
In-Reply-To: <6ec4247d0601030419w377fd396x@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Gower wrote:
> My logs were starting to fill with messages exatcly like that mentioned here:
> http://patchwork.netfilter.org/netfilter-devel/patch.pl?id=2840
> 
> In any event, the patch at the end of that link was never applied (it doesn't
> fix the other call to dev_kfree_skb). After applying my patch, I've not had any
> more messages in the logs.

The patch has been applied to 2.6.15-rc. Only the first hunk of your
patch is still required, but it doesn't apply anymore. Can you send
a new patch against 2.6.15 please?
