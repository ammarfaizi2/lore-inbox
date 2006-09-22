Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWIVSQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWIVSQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWIVSQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:16:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:38280 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964854AbWIVSQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:16:47 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] sky2 network driver
Date: Fri, 22 Sep 2006 11:16:14 -0700
Organization: OSDL
Message-ID: <20060922111614.42047f53@localhost.localdomain>
References: <bd0cb7950609220850k7186efco7e0b6328e9461bf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1158948974 31225 10.8.0.54 (22 Sep 2006 18:16:14 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 22 Sep 2006 18:16:14 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:50:19 -0400
"Tom St Denis" <tomstdenis@gmail.com> wrote:

> This patch fixes the sky2 network driver for 965P-S3 Gigabyte
> motherboards by adding the device ID required for this revision of the
> chipset.
> 
> Signed-Off-by: Tom St Denis <tomstdenis@gmail.com>
> 
> --- linux-2.6.18/drivers/net/sky2.c	2006-09-20 03:42:06.000000000 +0000
> +++ linux-2.6.18-tom/drivers/net/sky2.c	2006-09-22 21:28:03.000000000 +0000
> @@ -121,6 +121,7 @@
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4361) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4362) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4363) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4364) },
>  	{ 0 }
>  };

Already in upstream for 2.6.19 along with other id's

-- 
Stephen Hemminger <shemminger@osdl.org>
