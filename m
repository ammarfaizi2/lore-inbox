Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIJTdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIJTdb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUIJTdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:33:31 -0400
Received: from mail4.utc.com ([192.249.46.193]:22216 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267850AbUIJTaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:30:10 -0400
Message-ID: <4142005C.8070208@cybsft.com>
Date: Fri, 10 Sep 2004 14:28:28 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@raytheon.com, Lee Revell <rlrevell@joe-job.com>,
       Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
References: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com> <20040908184231.GA8318@elte.hu> <41411214.4000205@cybsft.com> <4141EAE5.5080202@cybsft.com> <20040910192608.GA18761@elte.hu>
In-Reply-To: <20040910192608.GA18761@elte.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>I also have some other traces from this system that I have not seen
>>before on my slower system. For instance this one where we spend ~204
>>usec in __spin_lock_irqsave:
>>
>>http://www.cybsft.com/testresults/2.6.9-rc1-bk12-S0/trace1.txt
>>
>>Or this one where we spend ~203 usec in sched_clock. That just doesn't
>>seem possible.
>>
>>http://www.cybsft.com/testresults/2.6.9-rc1-bk12-S0/trace4.txt
> 
> 
> seems quite similar to Mark's IDE-DMA related hardware latencies. Does 
> reducing the DMA mode via hdparm reduce these latencies?
> 
> 	Ingo
> 
I will give that a try shortly.

kr
