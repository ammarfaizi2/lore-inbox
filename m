Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWHPSVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWHPSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWHPSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:21:24 -0400
Received: from mga07.intel.com ([143.182.124.22]:40074 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751159AbWHPSVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:21:24 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,133,1154934000"; 
   d="scan'208"; a="103846247:sNHT94266977"
Date: Wed, 16 Aug 2006 11:03:57 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-ID: <20060816110357.B7305@unix-os.sc.intel.com>
References: <20060815175525.A2333@unix-os.sc.intel.com> <20060815212455.c9fe1e34.pj@sgi.com> <20060815214718.00814767.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060815214718.00814767.akpm@osdl.org>; from akpm@osdl.org on Tue, Aug 15, 2006 at 09:47:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:47:18PM -0700, Andrew Morton wrote:
> > > + * cpu_power indicates the computing power of each sched group. This is
> > > + * used for distributing the load between different sched groups
> > > + * in a sched domain.
> > 
> > Thanks for explaining what cpu_power means.
> >
> 
> Hope not.  To me, "computing power" means megaflops/sec, or Dhrystones
> (don't ask) or whatever.  If that's what "cpu_power" is referring to then
> the name is hopelessly ambiguous with peak joules/sec and a big renaming is
> due.

It refers to group's processing power. Perhaps "horsepower" is better term.

thanks,
suresh
