Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267532AbUHTARU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUHTARU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 20:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUHTARU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 20:17:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11451 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267532AbUHTARS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 20:17:18 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: paulmck@us.ibm.com
Subject: Re: kernbench on 512p
Date: Thu, 19 Aug 2004 20:16:10 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408191724.04422.jbarnes@engr.sgi.com> <20040819233837.GA2723@us.ibm.com>
In-Reply-To: <20040819233837.GA2723@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408192016.10064.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2004 7:38 pm, Paul E. McKenney wrote:
> > 41.4% 58.6%    0%  rcu_state
> > 61.3% 38.7%    0%    __rcu_process_callbacks+0x260
> > 41.4% 58.6%    0%    rcu_check_quiescent_state+0xf0
> >
> > So it looks like the dcache lock is the biggest problem on this system
> > with this load.  And although the rcu stuff has improved tremendously for
> > this system, it's still highly contended.
>
> Was this run using all of Manfred's RCU patches?  If not, it would be
> interesting to see what you get with full RCU_HUGE patchset.

So that stuff isn't in 2.6.8.1-mm1?  What I tested was pretty close to a stock 
version of that tree.  Where can I grab a version of that patchset that 
applies to a recent kernel?

Thanks,
Jesse
