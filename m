Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVGVDYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVGVDYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVGVDX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:23:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62868 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262030AbVGVDXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:23:55 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
cc: Paul Jackson <pj@sgi.com>, Matthew Helsley <matthltc@us.ibm.com>,
       akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-reply-to: Your message of Fri, 22 Jul 2005 11:06:14 +1000.
             <42E04686.9020107@bigpond.net.au> 
Date: Thu, 21 Jul 2005 20:00:36 -0700
Message-Id: <E1Dvnm8-0006iD-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005 11:06:14 +1000, Peter Williams wrote:
> Paul Jackson wrote:
> > Matthew wrote:
> > 
> >>I don't see the large ifdefs you're referring to in -mm's
> >>kernel/sched.c.
> > 
> > 
> > Perhaps someone who knows CKRM better than I can explain why the CKRM
> > version in some SuSE releases based on 2.6.5 kernels has substantial
> > code and some large ifdef's in sched.c, but the CKRM in *-mm doesn't.
> > Or perhaps I'm confused.  There's a good chance that this represents
> > ongoing improvements that CKRM is making to reduce their footprint
> > in core kernel code.  Or perhaps there is a more sophisticated cpu
> > controller in the SuSE kernel.
> 
> As there is NO CKRM cpu controller in 2.6.13-rc3-mm1 (that I can see) 
> the one in 2.6.5 is certainly more sophisticated :-).  So the reason 
> that the considerable mangling of sched.c evident in SuSE's 2.6.5 kernel 
> source is not present is that the cpu controller is not included in 
> these patches.
 
 Yeah - I don't really consider the current CPU controller code something
 ready for consideration yet for mainline merging.  That doesn't mean
 we don't want a CPU controller for CKRM - just that what we have
 doesn't integrate cleanly/nicely with mainline.

> I imagine that the cpu controller is missing from this version of CKRM 
> because the bugs introduced to the cpu controller during upgrading from 
> 2.6.5 to 2.6.10 version have not yet been resolved.

 I don't know what bugs you are referring to here.  I don't think we
 have any open defects with SuSE on the CPU scheduler in their releases.
 And that is not at all related to the reason for not having a CPU
 controller in the current patch set.

gerrit
