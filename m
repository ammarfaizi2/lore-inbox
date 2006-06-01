Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWFAX0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWFAX0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFAX0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:26:32 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:39553 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750860AbWFAX0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:26:31 -0400
Message-ID: <447F77A4.3000102@bigpond.net.au>
Date: Fri, 02 Jun 2006 09:26:28 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, Sam Vilain <sam@vilain.net>,
       ckrm-tech@lists.sourceforge.net, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	 <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	 <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	 <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	 <447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
In-Reply-To: <1149187413.13336.24.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 1 Jun 2006 23:26:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
>> Hi, Kirill,
>>
>> Kirill Korotaev wrote:
>>>> Do you have any documented requirements for container resource 
>>>> management?
>>>> Is there a minimum list of features and nice to have features for 
>>>> containers
>>>> as far as resource management is concerned?
>>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
>>> required resource management. BTW, I must agree with other people here 
>>> who noticed that per-process resource management is really useless and 
>>> hard to use :(
> 
> I totally agree.
>> I'll take a look at the references. I agree with you that it will be useful
>> to have resource management for a group of tasks.

But you don't need something as complex as CKRM either.  This capping 
functionality coupled with (the lamented) PAGG patches (should have been 
called TAGG for "task aggregation" instead of PAGG for "process 
aggregation") would allow you to implement a kernel module that could 
apply caps to arbitrary groups of tasks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
