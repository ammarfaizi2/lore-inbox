Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUJHHgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUJHHgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJHHgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:36:12 -0400
Received: from gizmo04bw.bigpond.com ([144.140.70.14]:64440 "HELO
	gizmo04bw.bigpond.com") by vger.kernel.org with SMTP
	id S267734AbUJHHgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 03:36:08 -0400
Message-ID: <41664364.20604@bigpond.net.au>
Date: Fri, 08 Oct 2004 17:36:04 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <56697.195.245.190.93.1097157219.squirrel@195.245.190.93> <32798.192.168.1.5.1097191570.squirrel@192.168.1.5> <1097213813.1442.2.camel@krustophenia.net> <20041008070654.GA30926@elte.hu>
In-Reply-To: <20041008070654.GA30926@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
>>On Thu, 2004-10-07 at 19:26, Rui Nuno Capela wrote:
>>
>>>Ingo Molnar wrote:
>>>
>>>>>i've released the -T3 VP patch:
>>>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>>>>>
>>>>
>>>OK. Just to let you know, both of my personal machines are now running on
>>>bleeding-edge 2.6.9-rc3-mm3-T3, and very happily may I assure :)
>>
>>This actually feels a _lot_ snappier than mm2, which seemed prone to
>>weird stalls.  I don't have any numbers to back this up yet.
> 
> 
> yeah, -mm is back to the development branch of the stock scheduler. 
> (i.e. the scheduler changes destined for 2.6.10.)

It's also got a fix for the cache hot timing bug which was causing havoc 
with the load balancer.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
