Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWA0CL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWA0CL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWA0CLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:11:25 -0500
Received: from fmr22.intel.com ([143.183.121.14]:451 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030205AbWA0CLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:11:25 -0500
Date: Thu, 26 Jan 2006 18:11:18 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Williams <pwil3058@bigpond.net.au>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Message-ID: <20060126181118.C19789@unix-os.sc.intel.com>
References: <20060126025220.B8521@unix-os.sc.intel.com> <200601271229.02752.kernel@kolivas.org> <20060126173423.B19789@unix-os.sc.intel.com> <200601271254.54009.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200601271254.54009.kernel@kolivas.org>; from kernel@kolivas.org on Fri, Jan 27, 2006 at 12:54:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 12:54:53PM +1100, Con Kolivas wrote:
> It's not my decision to keep Peter's patch out of mainline. If you can make a 
> strong enough case for it then Linus will merge it up even though it's after 
> rc1. 

I don't want to push Peters patch to 2.6.16, as I haven't tested much.

> Otherwise I'll let Ingo decide on whether to pull the current 
> implementation or not - you're saying that with the one thing you described 
> that misbehaves that it is doing more harm than fixing smp nice handling.

Are we sure that it really fixes smp nice handling? Its not just one 
scenario(bouncing processes on a lightly loaded system), I am talking about. 
Imbalance calculations will be wrong even on a completely loaded system.. 
Are you sure that there are no perf regressions with your patch..

Sorry for commenting on this patch so late.. I was on a very long vacation.
I think it is safe to back that out for 2.6.16 and do more work and get it
in 2.6.17.

thanks,
suresh
