Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291471AbSBMJeX>; Wed, 13 Feb 2002 04:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291466AbSBMJeN>; Wed, 13 Feb 2002 04:34:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25869 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291463AbSBMJeA>;
	Wed, 13 Feb 2002 04:34:00 -0500
Message-ID: <3C6A32D2.77ED71F@zip.com.au>
Date: Wed, 13 Feb 2002 01:33:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: [patch] printk and dma_addr_t
In-Reply-To: <3C6A2FCA.C4F49062@zip.com.au> from "Andrew Morton" at Feb 13, 2002 01:20:10 AM <E16avu8-0004lh-00@the-village.bc.nu>
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
> Vomit.

See, I said I should have used j.r.hacker@hotmail.com for this one.

> How about adding a dma_addr_t %code to the printk function ?

The compiler's printf arg checking will choke on that.

-
