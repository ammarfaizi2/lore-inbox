Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRIVVDq>; Sat, 22 Sep 2001 17:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRIVVDd>; Sat, 22 Sep 2001 17:03:33 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:14723 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S272197AbRIVVDT>; Sat, 22 Sep 2001 17:03:19 -0400
Date: Sat, 22 Sep 2001 16:03:44 -0500
From: Taral <taral@taral.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB lockup on Thinkpad i1300
Message-ID: <20010922160344.C26427@taral.net>
In-Reply-To: <20010922044527.A23908@taral.net> <E15kpyd-0003hF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15kpyd-0003hF-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 05:50:03PM +0100, Alan Cox wrote:
> 	save_flags(flags);
> 	cli();
> 	printh("Not dead yet\n");
> 	/* HC ...
> 	..
> 
> 	printk("Writel returned\n");
> 	readl(&ohci->regs->cmdstatus);
> 	printk("Write definitely occurred now\n");
> 	restore_flags(flags);
> 	printk("Ok with IRQ on\n");

I get "Not dead yet" then nothing.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
