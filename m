Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbXACPPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXACPPu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbXACPPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:15:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:47761 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbXACPPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:15:49 -0500
Date: Wed, 3 Jan 2007 20:47:04 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: Re: [PATCH 3/2] fix flush_workqueue() vs CPU_DEAD race
Message-ID: <20070103151704.GA28195@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061230161031.GA101@tv-sign.ru> <20070102162727.9ce2ae2b.akpm@osdl.org> <20070103140459.GA12620@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103140459.GA12620@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 07:34:59PM +0530, Gautham R Shenoy wrote:
> 
> > handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch
> 
> Again, this one ensures that workqueue_mutex is taken/released on
> CPU_LOCK_ACQUIRE/CPU_LOCK_RELEASE events in the cpuhotplug callback
> function. So this one is required, unless it conflicts with what Oleg
> has posted. Will check that out tonite.

We would still be needing this patch as it's complementing what Oleg has
posted.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
