Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWDKFs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWDKFs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 01:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWDKFs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 01:48:27 -0400
Received: from mga06.intel.com ([134.134.136.21]:55474 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751232AbWDKFs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 01:48:27 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.04,109,1144047600"; 
   d="scan'208"; a="21747191:sNHT17046281"
Date: Mon, 10 Apr 2006 22:47:09 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
Message-ID: <20060410224709.A28321@unix-os.sc.intel.com>
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443B0CF8.6060707@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443B0CF8.6060707@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Apr 11, 2006 at 11:57:12AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 11:57:12AM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > Can you give an example scenario where this patch helps? And doesn't
> > the normal imabalance calculations capture those issues?
> 
> Yes, I think that the normal imbalance calculations (in 
> find_busiest_queue()) will generally capture the aim of having 
> approximately equal average loads per task on run queues.  But this bit 
> of code is a special case in that the extra aggression being taken by 
> the load balancer (in response to a scenario raised by you) is being 

Can you give a specific example which shows the problem
and which you are trying to fix with this particular patch..

thanks,
suresh
