Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131585AbRAaJPz>; Wed, 31 Jan 2001 04:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131702AbRAaJPp>; Wed, 31 Jan 2001 04:15:45 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:16626 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131648AbRAaJP0>; Wed, 31 Jan 2001 04:15:26 -0500
Date: Wed, 31 Jan 2001 09:15:23 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
In-Reply-To: <FLRPM.A.TsC.j41d6@dinero.interactivesi.com>
Message-ID: <Pine.SOL.4.21.0101310914060.29972-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Timur Tabi wrote:

> ** Reply to message from Christopher Neufeld <neufeld@linuxcare.com> on Tue, 30
> Jan 2001 16:08:32 -0800
> 
> 
> > Would it be possible to bump it up to 128, or even
> > 256, in later 2.4.* kernel releases?  That would allow this customer to
> > work with an unpatched kernel, at the cost of an additional 3.5 kB of
> > variables in the kernel.
> 
> I don't think that's going to happen.  If we did this for your obscure system,
> then we'd have to do it for every obscure system, and before you know it, the
> kernel is 200KB larger.
> 
> Besides, why is your client afraid of patched kernels?  It sounds like a very
> odd request from someone with a linuxcare.com email address.  I would think that
> you'd WANT to provide patched kernels so that the customer can keep paying you
> (until they learn how to use a text editor, at which point they can patch the
> kernel themselves!!!)

Should there not at least be some bounds checking on this table, though?!

If it's only built at boot time, it's not performance critical. Maybe at a
later date it could even expand (or shrink, on small PCs??) the table as
needed?


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
