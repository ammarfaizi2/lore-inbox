Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUHEQwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUHEQwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUHEQuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:50:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46785 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267786AbUHEQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:49:45 -0400
Date: Thu, 5 Aug 2004 18:49:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Rick Lindsley <ricklind@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <20040805164936.GK2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org> <20040805111835.GB2746@fs.tum.de> <42030000.1091719559@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42030000.1091719559@[10.10.2.4]>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 08:25:59AM -0700, Martin J. Bligh wrote:
> --Adrian Bunk <bunk@fs.tum.de> wrote (on Thursday, August 05, 2004 13:18:35 +0200):
> 
> > On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
> >> ...
> >> Changes since 2.6.8-rc2-mm2:
> >> ...
> >> +schedstats-2.patch
> >> ...
> >>  CPU scheduler statitics
> >> ...
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      kernel/sched.o
> > kernel/sched.c: In function `show_schedstat':
> > kernel/sched.c:372: error: structure has no member named `sd'
> > kernel/sched.c:372: error: dereferencing pointer to incomplete type
> > kernel/sched.c:375: error: dereferencing pointer to incomplete type
> > kernel/sched.c:380: error: dereferencing pointer to incomplete type
> > kernel/sched.c:381: error: dereferencing pointer to incomplete type
> > kernel/sched.c:382: error: dereferencing pointer to incomplete type
> > kernel/sched.c:383: error: dereferencing pointer to incomplete type
> > kernel/sched.c:384: error: dereferencing pointer to incomplete type
> > kernel/sched.c:387: error: dereferencing pointer to incomplete type
> > kernel/sched.c:387: error: dereferencing pointer to incomplete type
> > kernel/sched.c:388: error: dereferencing pointer to incomplete type
> > kernel/sched.c:388: error: dereferencing pointer to incomplete type
> > make[1]: *** [kernel/sched.o] Error 1
> 
> Any chance you could try the version Ingo just posted instead?

I tried reverting the patch in -mm, but it was non-trivial.

I'll simply wait until -mm2 and report if the problem will still be 
present.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

