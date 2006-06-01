Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWFAXsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWFAXsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWFAXsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:48:30 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:45206 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751013AbWFAXsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:48:09 -0400
Message-ID: <447F7CA8.8040103@vilain.net>
Date: Fri, 02 Jun 2006 11:47:52 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
Cc: Kirill Korotaev <dev@openvz.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org> <447EA694.8060407@in.ibm.com>
In-Reply-To: <447EA694.8060407@in.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>>1) CPU:
>>- fairness (i.e. prioritization of containers). For this we use SFQ like 
>>fair cpu scheduler with virtual cpus (runqueues). Linux-vserver uses 
>>tocken bucket algorithm. I can provide more details on this if you are 
>>interested.
>>    
>>
>Yes, any information or pointers to them will be very useful.
>  
>
A general description of the token bucket scheduler is on the Vserver
wiki at http://linux-vserver.org/Linux-VServer-Paper-06

I also just described it on a nearby thread -
http://lkml.org/lkml/2006/5/28/122

Sam.


