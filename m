Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUIJK1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUIJK1U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUIJK1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:27:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24070 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266888AbUIJK1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:27:18 -0400
Date: Fri, 10 Sep 2004 11:27:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjanv@redhat.com, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910112706.C22599@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094807650.17041.3.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 10, 2004 at 10:14:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 10:14:11AM +0100, Alan Cox wrote:
> On Gwe, 2004-09-10 at 07:40, Arjan van de Ven wrote:
> > Well I always assumed the future plan was to remove 8k stacks entirely;
> > 4k+irqstacks and 8k basically have near comparable stack space, with
> > this patch you create an option that has more but that is/should be
> > deprecated. I'm not convinced that's a good idea.
> 
> Its probably appropriate to drop gcc 2.x support at that point too since
> it's the major cause of remaining problems

I have no problem with that - gcc 3.3 on ARM has proven itself (to me
at least) be a stable compiler so I'm not using anything older than
that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
