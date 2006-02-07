Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWBGXhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWBGXhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWBGXhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:37:05 -0500
Received: from smtp-out.google.com ([216.239.45.12]:4463 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932476AbWBGXhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:37:03 -0500
Message-ID: <43E92EEE.7040706@google.com>
Date: Tue, 07 Feb 2006 15:36:14 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
References: <20060207142828.GA20930@wotan.suse.de>	<200602080157.07823.kernel@kolivas.org> <20060207141525.19d2b1be.akpm@osdl.org> <43E92B2B.2060105@bigpond.net.au>
In-Reply-To: <43E92B2B.2060105@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think that the problems with excessive idling with the early versions 
> of my modifications to Con's patch showed that the load balancing code 
> is fairly sensitive to the average load per normal task not being 
> approximately 1.  My latest patches restore this state of affairs and 
> kernbench testing indicates that the excessive idling has gone away (see 
> Martin J Bligh's message of 2006/01/29 11:52 "Re: -mm seems 
> significantly slower than mainline on kernbench thread").

I *think* the latest slowdown in -mm was due to some TSC side effects 
from John's patches - see his other patch earlier today to fix (oops,
I forgot to reply to that ..)

So AFAICS, all issues with Peter's stuff were fixed.
