Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVBKFE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVBKFE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 00:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVBKFEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 00:04:55 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:5536 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262176AbVBKFEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 00:04:52 -0500
Subject: Re: 2.6.11-rc3-mm2
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, Matt Mackall <mpm@selenic.com>,
       Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <jack.oquin@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       rlrevell@joe-job.com, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200502110341.j1B3fS8o017685@localhost.localdomain>
References: <200502110341.j1B3fS8o017685@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 16:04:46 +1100
Message-Id: <1108098286.5098.41.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 22:41 -0500, Paul Davis wrote:
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
> 

Sure, it is quick and easy. Suits some. At least I do prefer
this to altering the semantics of realtime scheduling.

I can't say much about it because I'm not putting my hand up to
do anything. Just mentioning that rlimit would be better if not
for the userspace side of the equation. I think most were already
agreed on that point anyway though.

Nick



