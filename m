Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTEVBbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTEVBbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:31:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:41370 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262442AbTEVBbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:31:50 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: userspace irq balancer 
In-reply-to: Your message of Wed, 21 May 2003 18:28:56 PDT.
             <58830000.1053566935@[10.10.2.4]> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2134.1053567886.1@us.ibm.com>
Date: Wed, 21 May 2003 18:44:46 -0700
Message-Id: <E19If8R-0000YU-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003 18:28:56 PDT, "Martin J. Bligh" wrote:
> > Yeah, I suppose this userland policy change means we should pull
> > the scheduler policy decisions out of the kernel and write user level
> > HT, NUMA, SMP and UP schedulers.  Also, the IO schedulers should
> > probably be pulled out - I'm sure AS and CFQ and linus_scheduler
> > could be user land policies, as well as the elevator.  Memory
> > placement and swapping policies, too.
> > 
> > Oh, wait, some people actually do this - they call it, what,
> > Workload Management or some such thing.  But I don't know any
> > style of workload management that leaves *no* default, semi-sane
> > policy in the kernel.
> 
> I think the word you're groping for here is "microkernel".
> 
> M.

Oh, yeah.  Page replacement policy in user level.  That one was
a real winner.

gerrit
