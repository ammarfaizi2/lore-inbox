Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTGBCyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTGBCyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:54:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50130
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264551AbTGBCyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:54:20 -0400
Date: Wed, 2 Jul 2003 05:08:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702030818.GX3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307012236310.16265@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307012236310.16265@skynet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 10:46:31PM +0100, Mel Gorman wrote:
> On Tue, 1 Jul 2003, Andrea Arcangeli wrote:
> 
> > On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> > >    Reverse Page Table Mapping
> > >    ==========================
> > >
> > > <rmap stuff snipped>
> >
> > you mention only the positive things, and never the fact that's the most
> > hurting piece of kernel code in terms of performance and smp scalability
> > until you actually have to swapout or pageout.
> >
> 
> You're right, I was commenting only on the positive side of things. I
> didn't pay close enough attention to the development of the 2.5 series so
> right now I can only comment on whats there and only to a small extent on
> what it means or why it might be a bad thing. Here goes a more balanced
> view...

never mind, I think for your talk that was just perfect ;) Though I
think your last paragraph addition on the rmap thing is fair enough.

I only abused your very nice and detailed list of features, to comment
on some that IMHO had some drawback (and for some [not rmap] I don't
recall any discussion about their drawbacks on l-k ever, that's why I
answered).

thanks,

Andrea
