Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266660AbUAWTS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUAWTS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:18:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19383 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266660AbUAWTRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:17:31 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
	 <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
	 <1074709166.16374.73.camel@cog.beaverton.ibm.com>
	 <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074800554.21658.68.camel@cog.beaverton.ibm.com>
	 <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074801242.21658.71.camel@cog.beaverton.ibm.com>
	 <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074806504.21658.76.camel@cog.beaverton.ibm.com>
	 <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074885449.12446.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 23 Jan 2004 11:17:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 11:02, timothy parkinson wrote:
> On Thu, Jan 22, 2004 at 01:21:45PM -0800, john stultz wrote:
> > Its likely you need to enable support in the kernel for your IDE
> > controller, or your DMA on your controller isn't supported.  
> 
> so, apparently the problem was that i just needed to enable dma...  which meant
> that i needed to set "CONFIG_BLK_DEV_VIA82CXXX=y" in my .config.
> 
> been running all night/morning with load - no "losing ticks" message or slowing
> clock yet.  thanks for pointing me in the right direction.
> 
> think we could improve that error message?  i'd never have guessed that it was
> hard disk related if you hadn't told me...

Well, lost ticks can be caused by many things, but your point is valid,
the message could be a bit more elightening. 

thanks
-john


