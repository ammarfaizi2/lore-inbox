Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264547AbSIVVZu>; Sun, 22 Sep 2002 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264557AbSIVVZu>; Sun, 22 Sep 2002 17:25:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18074 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264547AbSIVVZt>;
	Sun, 22 Sep 2002 17:25:49 -0400
Date: Sun, 22 Sep 2002 23:39:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.12948.103681.852724@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209222333470.19919-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, bob wrote:

> There is no drag on the kernel.  The concept that we are working on is
> consistent with your below recommendations.  Only place in the kernel an
> efficient tracing infrastructure, keep trace points as patches. [...]

well, this is not the impression i got from the patches posted to lkml ...

> [...] This adds no overhead to kernel, allows your suggested patches to
> use a standard efficient infrastructure, reduces replicated work from
> specific problem to specific problem.

so why not keep the core parts as separate patches as well? If it does
nothing then i dont see why it should get into the kernel proper.

>  > my problem with this stuff is conceptual: it introduces a constant drag on
>  > the kernel sourcecode, while 99% of development will not want to trace,
> 
> If you care about performance you will want to trace.  On two previous
> kernels I have worked on I've heard this comment.  Once the
> infrastructure was in it was used and appreciated.

(i think you have not read what i have written. I use tracing pretty
frequently, and no, i dont need tracing in the kernel, during development
i can apply patches to kernel trees just fine.)

	Ingo

