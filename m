Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTGHROS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTGHROS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:14:18 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:46226
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264958AbTGHROM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:14:12 -0400
Date: Tue, 8 Jul 2003 13:28:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES for CryptoAPI - i586-optimized
Message-ID: <20030708172848.GA17115@gtf.org>
References: <20030708152755.GA24331@ghanima.endorphin.org.suse.lists.linux.kernel> <20030708174907.A18997@infradead.org.suse.lists.linux.kernel> <p737k6tq6x0.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p737k6tq6x0.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 07:12:27PM +0200, Andi Kleen wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Jul 08, 2003 at 05:27:55PM +0200, Fruhwirth Clemens wrote:
> > > 
> > > Due to the recent discussion about the asm-optimized version of AES which is
> > > included in loop-AES, I'd like to point out that I've ported this
> > > implementation - Dr. Brian Gladman's btw. - to CryptoAPI a long time ago.
> > 
> > Cool, that means we just need to hash out the framework for optimized
> > implementations now..
> 
> It's not cool. Pentium Classic tuning is quite useless for PPro+
> The Pentium Classic had a quite weird pipeline and code optimized
> for it tends to be suboptimal for more modern designs.
> 
> I didn't benchmark, but I suspect the C version compiled with a good compiler
> for the correct CPU is faster than that on a modern CPU.

I agree 100% with what you state here... but at the same time I was
thinking it would be nice to merge, mainly as an example of asm support
if nothing else.

We really need to see benchmarks before merging, too, to see (as you
state) if the C compiler still does a better job.

	Jeff



