Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268173AbUHTPAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268173AbUHTPAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHTO6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:58:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48339 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268155AbUHTO5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:57:55 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add scheduler domains for ia64
Date: Fri, 20 Aug 2004 10:57:30 -0400
User-Agent: KMail/1.6.2
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hawkes@sgi.com, mingo@elte.hu
References: <200408131108.40502.jbarnes@engr.sgi.com> <200408192222.35512.jbarnes@engr.sgi.com> <20040819232855.5d919155.akpm@osdl.org>
In-Reply-To: <20040819232855.5d919155.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201057.30813.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 2:28 am, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > Yep, it's been working ok so far.  There's still more we can do, but this
> > is a good start I think.  Andrew, this version applies on top of
> > 2.6.8.1-mm2 but overwrites most of the earlier node-span patch by moving
> > bits from arch/ia64 to kernel/sched.c, so let me know if you want the
> > patch in a different format.
>
> Is OK.  I wiggled it into the logical place so we'll end up with a sane
> patch series.
>
> Watch the warnings please...
>
>
>
> kernel/sched.c:3732: warning: `sched_domain_node_span' defined but not used

Oops, sorry about that!  I meant to test with CONFIG_NUMA=n but fell asleep.  
I'll be more careful in the future.

Jesse
