Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUACCvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 21:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUACCvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 21:51:23 -0500
Received: from pD9E56DF6.dip.t-dialin.net ([217.229.109.246]:2713 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S262328AbUACCvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 21:51:21 -0500
Date: Sat, 3 Jan 2004 03:51:19 +0100
From: Andi Kleen <ak@muc.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 compile error
Message-ID: <20040103025119.GA19647@averell>
References: <18PmG-40b-9@gated-at.bofh.it> <m3znd7ib1b.fsf@averell.firstfloor.org> <200401031309.10816.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401031309.10816.harisri@bigpond.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 01:09:10PM +1100, Srihari Vijayaraghavan wrote:
> Hello Andi,
> 
> On Friday 02 January 2004 09:01, Andi Kleen wrote:
> > Srihari Vijayaraghavan <harisri@bigpond.com> writes:
> > > While "make bzImage", it showed these error messages:
> > >   CC      arch/x86_64/kernel/io_apic.o
> >
> > I already submitted a patch to fix that and Linus merged it.
> > Use current -bk*
> 
> Unfortunately the current -bk* would not apply cleanly. For eg, 
> patch-2.6.1-rc1-bk3 does not apply to 2.6.1-rc1. Maybe when 2.6.1-rc2 is out 
> I shall try it out at that time.

It applied fine for me. Maybe your trees are corrupted. 

> (BTW I have tried 2.6.1-rc1-x8664-1, and all is fine with that.)

There's one bug in there that breaks it on some boxes.

-Andi
