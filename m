Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSFXJMA>; Mon, 24 Jun 2002 05:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSFXJL7>; Mon, 24 Jun 2002 05:11:59 -0400
Received: from www.scba.org.sz ([196.28.7.66]:65193 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311752AbSFXJL5>; Mon, 24 Jun 2002 05:11:57 -0400
Date: Mon, 24 Jun 2002 09:30:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 : drivers/net/defxx.c 
In-Reply-To: <Pine.LNX.4.44.0206232225410.922-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206240929080.2603-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Frank Davis wrote:

> -
> +	if(pci_set_dma_mask(pdev, 0xffffffff))
> +	{
> +		printk(KERN_WARNING "defxx : No suitable DMA available\n");
> +	}

Minor nit,
	CodingStyle prefers this style;

	if (pci_set_dma_mask(pdev, 0xffffffff))
		printk(KERN_WARNING "defxx : No suitable DMA available\n");

Thanks,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

