Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVCaOpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVCaOpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCaOpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:45:47 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26000 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261480AbVCaOpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:45:21 -0500
Message-ID: <424C0D4C.4060003@watson.ibm.com>
Date: Thu, 31 Mar 2005 09:46:36 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: Diego Calleja <diegocg@gmail.com>, gh@us.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [patch 0/8] CKRM: Core patch set
References: <20050330225505.7a443227.diegocg@gmail.com>	<E1DGkl7-0002aV-00@w-gerrit.beaverton.ibm.com>	<20050331002900.5c5dd04a.diegocg@gmail.com> <20050330173232.3ae4c791.pj@engr.sgi.com>
In-Reply-To: <20050330173232.3ae4c791.pj@engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Diego wrote:
> 
>>I bet I'm not the only one here
>>who can't understand it either.....
> 
> 
> You're not alone.
> 
> See an email thread entitled:
> 
>     Classes: 1) what are they, 2) what is their name?
>     http://sourceforge.net/mailarchive/forum.php?thread_id=5328162&forum_id=35191
> 
> on the ckrm-tech@lists.sourceforge.net email list between Aug 14 and Aug
> 27, 2004, where I did my best to encourage the CKRM project to address
> this problem.  To no avail.

That is not really a fair categorization of the thread. Hubertus and I 
did try to explain what CKRM classes are. As the last parts of the 
thread show, it was the choice of names that you disagreed with.

> Apparently, to some of the smartest amongst us, who got to hear
> live presentations describing CKRM, it makes sense and is worthy
> of serious consideration.

Except for the Kernel Summit talk (slides of which were very brief),
you have access to the very same presentations on the ckrm website.

> For myself, of more ordinary intelligence and working just from the
> documentation and an occassional glance at the code, it has been a
> difficult proposal to understand, with a rather large patch requiring
> some non-trivial kernel hooks.


Have you read Section 2 of the
	http://ckrm.sourceforge.net/downloads/ckrm-ols04-paper.pdf

There the terms class, classtype, resource controllers and 
classification engine have all been explained. If you continue to have 
trouble understanding what these mean, we'd be happy to go over it once 
more. Perhaps we should try a twiki type site or come up with a specific 
set of doubts that need to be addressed.


> A question for the CKRM developers:
> 
>     What middleware packages, outside the kernel, exist or are
>     in the works that will rely on CKRM?
>     
>     CKRM (like another project near and dear to me, cpusets)
>     strikes me as a "middleware foundation" facility, intended
>     to provide the essential kernel support required for some
>     serious enterprise software.  So perhaps in addition to
>     asking what end-users (of a combined kernel-middleware
>     platform) exist, we should also be asking who will be
>     directly using CKRM - directly layering middleware on top
>     of it.
>     
>     The details don't matter much and may have to remain
>     obscured in the competitive fog.  But the presence of
>     multiple groups lobbying for the same kernel infrastructure,
>     as an apparent basis for competing middleware products,
>     would I think weigh in CKRM's favor.

Undoubtedly so. However, workload management middleware developers don't 
seem to have a history of actively participating in LKML for useful 
features so its left to the likes of us to determine what *would* be 
useful and then go build it if it makes sense and is acceptable to the 
community.


> My impression, which may not align with how the CKRM developers view
> things, is that CKRM is descendent from what have been called fair-share
> schedulers.  The following comes from the above email thread.

Doing fair-share scheduling is indeed the ultimate goal of CKRM. But 
using that characterization *alone* will not, in my opinion, be 
sufficient to explain what are classes, classtypes etc.

> No doubt the CKRM experts are already familiar with these, but for the
> possible benefit of other readers:
> 
>   UNICOS Resource Administration - Chapter 4. Fair-share Scheduler
>   http://oscinfo.osc.edu:8080/dynaweb/all/004-2302-001/@Generic__BookTextView/22883
> 
>   SHARE II -- A User Administration and Resource Control System for UNIX
>   http://www.c-side.com/c/papers/lisa-91.html
> 
>   Solaris Resource Manager White Paper
>   http://wwws.sun.com/software/resourcemgr/wp-mixed/
> 
>   ON THE PERFORMANCE IMPACT OF FAIR SHARE SCHEDULING
>   http://www.cs.umb.edu/~eb/goalmode/cmg2000final.htm
> 
>   A Fair Share Scheduler, J. Kay and P. Lauder
>   Communications of the ACM, January 1988, Volume 31, Number 1, pp 44-55.

Thanks for the links. Yes, some of these are useful in understanding the 
utility of fair-share scheduling and may even help in creating better 
"controllers" in CKRM-speak.


-- Shailabh


