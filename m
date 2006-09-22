Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWIVA51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWIVA51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWIVA51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:57:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6073 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbWIVA50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:57:26 -0400
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, menage@google.com,
       devel@openvz.org, clameter@sgi.com
In-Reply-To: <20060921172427.25ddb7ea.pj@sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <1158875062.6536.210.camel@linuxchandra>
	 <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
	 <1158883601.6536.223.camel@linuxchandra>
	 <20060921172427.25ddb7ea.pj@sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 21 Sep 2006 17:57:22 -0700
Message-Id: <1158886642.6536.233.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 17:24 -0700, Paul Jackson wrote:
> Chandra wrote:
> > There are two (competing) memory controllers in the kernel. But, distro
> > can turn only one ON. 
> 
> Huh - time for me to play the dummy again ...
> 
> My (fog shrouded) vision of the future has:
>  1) mempolicy - provides fine grained memory placement for task on self
>  2) cpuset - provides system wide cpu and memory placement for unrelated tasks
>  3) some form of resource groups - measures and limits proportion of various
>     resources used, including cpu cycles, memory pages and network bandwidth,
>     by collections of tasks.k
> 
> Both (2) and (3) need to group tasks in flexible ways distinct from the
> existing task groupings supported by the kernel.
> 
> I thought that Paul M suggested (2) and (3) use common underlying
> grouping or 'bucket' technology - the infrastructure that separates
> tasks into buckets and can be used to associate various resource
> metrics and limits with each bucket.
> 
> I can't quite figure out whether you have in mind above:
>  * a conflict between two competing memory controllers for (3),

Yes.
>  * or a conflict between cpusets and one memory controller for (3).

No.
> 
> And either way, I don't see what that has to do with the underling
> bucket technology - how we group tasks generically.

True. I clarified it in the reply to Paul M.
> 
> Guess I am missing something ...
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


