Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWFFI3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWFFI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWFFI3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:29:24 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:7803 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751177AbWFFI3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:29:24 -0400
Message-ID: <44853BCA.4010009@sw.ru>
Date: Tue, 06 Jun 2006 12:24:42 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Kirill Korotaev <dev@openvz.org>, Peter Williams <pwil3058@bigpond.net.au>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>		<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>		<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>		<44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>		<447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>		<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra> <447FD2E1.7060605@bigpond.net.au> <447FECFD.8000602@openvz.org> <4484ABF9.50503@vilain.net>
In-Reply-To: <4484ABF9.50503@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I'm sorry, but nice never looked "nice" to me.
>>Have you ever tried to "nice" apache server which spawns 500 
>>processes/threads on a loaded machine?
>>With nice you _can't_ impose limits or priority on the whole "apache".
>>The more apaches you have the more useless their priorites and nices are...
>> 
>>
> 
> 
> Yes but interactive admin processes will still get a large bonus
> relative to the apache processes so you can still log in and kill the
> apache storm off even with very large loads.

And how do you plan to manage it: to log in every time when apache works 
too much and kill processes? The managabiliy of such solutions sucks..

Kirill

