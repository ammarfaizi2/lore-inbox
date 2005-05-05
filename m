Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVEEQOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVEEQOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVEEQOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:14:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:468 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262144AbVEEQOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:14:24 -0400
Date: Thu, 5 May 2005 21:45:13 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, george@mvista.com,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
Message-ID: <20050505161513.GA20217@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050407124629.GA17268@in.ibm.com> <425530AB.90605@yahoo.com.au> <20050505143958.GA20162@in.ibm.com> <427A3340.1020305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427A3340.1020305@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 12:52:48AM +1000, Nick Piggin wrote:
> Well, there are a lot of ifs and buts. Some domains won't implement
> fork balancing, others won't do newidle balancing, wake balancing,
> wake to idle, etc etc.

Good point. I had somehow assumed that these are true for all domains.
My bad ..

> 
> I think my idea of allowing max_interval to be extended to a
> sufficiently large value if one CPU goes idle, and shutting off all
> CPU's rebalancing completely if no tasks are running for some time
> should cater to both hypervisor images and power saving concerns.

Maybe we should check with virtual machine folks on this. Will
check with UML and S390 folks tomorrow.

> >A possible patch for B follows below:
> >
> 
> Yeah something like that should do it.

Ok ..thanks. Will include this patch in the final 
load-balance-fix-for-no-hz-idle-cpus's patch!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
