Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWCWBiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWCWBiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCWBiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:38:22 -0500
Received: from fmr22.intel.com ([143.183.121.14]:61595 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932505AbWCWBiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:38:21 -0500
Date: Wed, 22 Mar 2006 17:37:54 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: kernel@kolivas.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
Message-ID: <20060322173754.A19085@unix-os.sc.intel.com>
References: <20060322155122.2745649f.akpm@osdl.org> <1143068226.4421d6424ecf1@vds.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1143068226.4421d6424ecf1@vds.kolivas.org>; from kernel@kolivas.org on Thu, Mar 23, 2006 at 09:57:06AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:57:06AM +1100, kernel@kolivas.org wrote:
> Quoting Andrew Morton <akpm@osdl.org>:
> > #
> > # "strange load balancing problems": pwil3058@bigpond.net.au
> > sched-new-sched-domain-for-representing-multi-core.patch
> > sched-fix-group-power-for-allnodes_domains.patch
> > x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch

I'd like to see the three above patches in 2.6.17. Peters "strange load
balancing problems" seems to be a false alarm(this patch will have
minimal impact on a single core cpu because of domain degeneration..) and
doesn't happen on recent -mm kernels..

> > 
> > 
> > I'm not sure what the "Suresh had problems" comment refers to - perhaps a
> > now-removed patch.
> 
> On previous versions of smp nice Suresh found some throughput issues. Peter has
> addressed these as far as I'm aware, but we really need Suresh to check all
> those again.

I am just back from vacation. I will soon review and provide feedback.

> > 
> > afaik, the load balancing problem which Peter observed remains unresolved.
> 
> That was a multicore enabled balancing problem which he reported went away on a
> later -mm.

thanks,
suresh
