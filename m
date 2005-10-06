Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVJFTa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVJFTa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVJFTa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:30:26 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:20405
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1751331AbVJFTaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:30:25 -0400
Date: Thu, 6 Oct 2005 15:24:25 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14-rc3
Message-ID: <20051006192425.GA11871@kevlar.burdell.org>
References: <4344F6A4.2070707@yahoo.com.au> <200510061836.j96Iamg19185@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510061836.j96Iamg19185@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 11:36:47AM -0700, Chen, Kenneth W wrote:
> Nick Piggin wrote on Thursday, October 06, 2005 3:04 AM
> > Arjan van de Ven wrote:
> > >>dbench is catching some attention.  We just ran it with default
> > >>parameter.  I don't think default parameter is the right one to use
> > >>on some of our configurations.  For example, it shows +100% improvement
> > > 
> > > never ever consider dbench a serious benchmark; the thing is you can
> > > make dbench a lot better very easy; just make the kernel run one thread
> > > at a time until completion. dbench really gives very variable results,
> > > but it is not really possible to say if +100% or -100% is an improvement
> > > or a degredation for real life. So please just don't run it, or at least
> > > don't interpret the results in a "higher is better" way.
> > > 
> > 
> > As a disk IO performance benchmark you are absolutely right.
> > 
> > Some people like using it to test VM scalability and throughput
> > if it is being used on tmpfs. In that case the results are
> > generally more stable.
> 
> Thank you for the suggestion, we will look into the options.  I agree here
> as well, and I also don't consider dbench as a serious disk I/O performance
> benchmark.  There are other workloads that we ran (IOzone, aiostress, and my
> favorite "industry standard database workload") which covers disk I/O side
> pretty well.

Also, make sure you are running dbench version 3, it has much much
better reproducibility and self-consistency than version 2.

Sonny
