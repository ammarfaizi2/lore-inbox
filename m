Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVJFSgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVJFSgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVJFSgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:36:54 -0400
Received: from fmr21.intel.com ([143.183.121.13]:15555 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751285AbVJFSgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:36:53 -0400
Message-Id: <200510061836.j96Iamg19185@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel performance update - 2.6.14-rc3
Date: Thu, 6 Oct 2005 11:36:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXKXXWHcla6mCmGRuK93tyJO5AcFAARmX0A
In-Reply-To: <4344F6A4.2070707@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, October 06, 2005 3:04 AM
> Arjan van de Ven wrote:
> >>dbench is catching some attention.  We just ran it with default
> >>parameter.  I don't think default parameter is the right one to use
> >>on some of our configurations.  For example, it shows +100% improvement
> > 
> > never ever consider dbench a serious benchmark; the thing is you can
> > make dbench a lot better very easy; just make the kernel run one thread
> > at a time until completion. dbench really gives very variable results,
> > but it is not really possible to say if +100% or -100% is an improvement
> > or a degredation for real life. So please just don't run it, or at least
> > don't interpret the results in a "higher is better" way.
> > 
> 
> As a disk IO performance benchmark you are absolutely right.
> 
> Some people like using it to test VM scalability and throughput
> if it is being used on tmpfs. In that case the results are
> generally more stable.

Thank you for the suggestion, we will look into the options.  I agree here
as well, and I also don't consider dbench as a serious disk I/O performance
benchmark.  There are other workloads that we ran (IOzone, aiostress, and my
favorite "industry standard database workload") which covers disk I/O side
pretty well.

- Ken

