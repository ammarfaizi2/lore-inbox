Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291470AbSBMJen>; Wed, 13 Feb 2002 04:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291466AbSBMJee>; Wed, 13 Feb 2002 04:34:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291463AbSBMJeU>;
	Wed, 13 Feb 2002 04:34:20 -0500
Message-ID: <3C6A331A.2D793119@mandrakesoft.com>
Date: Wed, 13 Feb 2002 04:34:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] printk and dma_addr_t
In-Reply-To: <E16avu8-0004lh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > dma_addr_t type.   So the above usage will become
> >
> >       printk("stuff: " DMA_ADDR_T_FMT " %s", a, s);
> 
> Vomit. How about adding a dma_addr_t %code to the printk function ?

heh, my comment on the patch was, "about as good as you can do without
teaching printk and gcc about the type"

Can we hack gcc warnings, too?

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
