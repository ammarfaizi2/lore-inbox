Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWFBCCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWFBCCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFBCCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:02:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:10190 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751094AbWFBCCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:02:45 -0400
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, Sam Vilain <sam@vilain.net>,
       ckrm-tech@lists.sourceforge.net, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
In-Reply-To: <447F77A4.3000102@bigpond.net.au>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>
	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>
	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>
	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
	 <447F77A4.3000102@bigpond.net.au>
Content-Type: text/plain
Organization: IBM
Date: Thu, 01 Jun 2006 19:02:39 -0700
Message-Id: <1149213759.10377.7.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 09:26 +1000, Peter Williams wrote:
> Chandra Seetharaman wrote:
> > On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> >> Hi, Kirill,
> >>
> >> Kirill Korotaev wrote:
> >>>> Do you have any documented requirements for container resource 
> >>>> management?
> >>>> Is there a minimum list of features and nice to have features for 
> >>>> containers
> >>>> as far as resource management is concerned?
> >>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
> >>> required resource management. BTW, I must agree with other people here 
> >>> who noticed that per-process resource management is really useless and 
> >>> hard to use :(
> > 
> > I totally agree.
> >> I'll take a look at the references. I agree with you that it will be useful
> >> to have resource management for a group of tasks.
> 
> But you don't need something as complex as CKRM either.  This capping

All CKRM^W Resource Groups does is to group unrelated/related tasks to a
group and apply resource limits. 

>  
> functionality coupled with (the lamented) PAGG patches (should have been 
> called TAGG for "task aggregation" instead of PAGG for "process 
> aggregation") would allow you to implement a kernel module that could 
> apply caps to arbitrary groups of tasks.

I do not follow how PAGG + this cap feature can be used to put cap of
related/unrelated tasks. Can you provide little more explanation,
please.

Also, i do not think it can provide guarantees to that group of tasks.
can it ?

> 
> Peter
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


