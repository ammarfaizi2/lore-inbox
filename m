Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVBKFJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVBKFJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 00:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVBKFJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 00:09:53 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.40]:5085 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S262192AbVBKFJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 00:09:35 -0500
Message-ID: <420C3E04.1000804@bigpond.net.au>
Date: Fri, 11 Feb 2005 16:09:24 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       rlrevell@joe-job.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm2
References: <200502110341.j1B3fS8o017685@localhost.localdomain>
In-Reply-To: <200502110341.j1B3fS8o017685@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis wrote:
>   [ the best solution is .... ]
> 
>   [ my preferred solution is ... ]
> 
>   [ it would be better if ... ]
> 
>   [ this is a kludge and it should be done instead like ... ]
> 
> did nobody read what andrew wrote and what JOQ pointed out?
> 
> after weeks of debating this, no other conceptual solution emerged
> that did not have at least as many problems as the RT LSM module, and
> all other proposed solutions were also more invasive of other aspects
> of kernel design and operations than RT LSM is.

As I see it, what I said was in support of RT LSM (or at least the 
approach that RT LSM is taking) so why are you attacking me.  I'm on 
your side :-)

Peter
PS I'm withdrawing the "unprivileged real time" feature from the 
spa_no_frills and zaphod schedulers in the PlugSched patch as a result 
of the discussions on SCHED_ISO and RT rlimits because the discussion 
convinced me that it's the wrong way to go.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
