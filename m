Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265025AbUFGVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbUFGVJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFGVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:09:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:48046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265025AbUFGVJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:09:19 -0400
Date: Mon, 7 Jun 2004 14:09:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>, Jamal Hadi Salim <hadi@zynx.com>,
       "David S. Miller" <davem@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc3
In-Reply-To: <20040607204142.GA26986@infradead.org>
Message-ID: <Pine.LNX.4.58.0406071407190.1637@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406071227400.2550@ppc970.osdl.org>
 <20040607204142.GA26986@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, Christoph Hellwig wrote:
> 
> This one here:
> 
> diff -Nru a/include/linux/netfilter_arp.h b/include/linux/netfilter_arp.h
> --- a/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
> +++ b/include/linux/netfilter_arp.h     2004-06-07 21:58:09 +02:00
> @@ -17,4 +17,5 @@
>  #define NF_ARP_FORWARD 2
>  #define NF_ARP_NUMHOOKS        3
> 
> +static DECLARE_MUTEX(arpt_mutex);
>  #endif /* __LINUX_ARP_NETFILTER_H */
> 
> looks perfectly fucked up.

Agreed. David? Jamal?

(Hey, first time when I used the "Signed-off-by:" info. Very good).

		Linus
