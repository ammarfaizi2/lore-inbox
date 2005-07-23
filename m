Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVGWR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVGWR07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGWR06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:26:58 -0400
Received: from hermes.domdv.de ([193.102.202.1]:39945 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261250AbVGWR06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:26:58 -0400
Message-ID: <42E27DD6.9030309@domdv.de>
Date: Sat, 23 Jul 2005 19:26:46 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.13rc3: RLIMIT_RTPRIO broken
References: <42E22D0C.1010608@domdv.de> <1122138559.15281.11.camel@mindpipe>
In-Reply-To: <1122138559.15281.11.camel@mindpipe>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2005-07-23 at 13:42 +0200, Andreas Steinmetz wrote:
> 
>>RLIMIT_RTPRIO is supposed to grant non privileged users the right to use
>>SCHED_FIFO/SCHED_RR scheduling policies with priorites bounded by the
>>RLIMIT_RTPRIO value via sched_setscheduler(). This is usually used by
>>audio users.
>>
>>Unfortunately this is broken in 2.6.13rc3 as you can see in the excerpt
>>from sched_setscheduler below:
> 
> 
> Please provide the Signed-Off-By line.  Also I have cc'ed Matt Mackall,
> the original author of the patch.

Sorry, I do forget this all the time...

Signed-off-by: Andreas Steinmetz <ast@domdv.de>
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
