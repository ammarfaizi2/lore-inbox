Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSA2Xi4>; Tue, 29 Jan 2002 18:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSA2Xh3>; Tue, 29 Jan 2002 18:37:29 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35345 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S286871AbSA2Xgu>; Tue, 29 Jan 2002 18:36:50 -0500
Date: Tue, 29 Jan 2002 18:36:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: yodaiken@fsmlabs.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020121165659.A20501@hq.fsmlabs.com>
Message-ID: <Pine.LNX.3.96.1020129181439.31511I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 yodaiken@fsmlabs.com wrote:

> I have not seen that argued - certainly I have not argued it myself.
> My argument is:
> 	It makes the kernel _much_ more complex
  It modifies a tiny fraction of a percent of the kernel, which is
currently simplistic rather than simple. Nearly everyone who looks at it
makes some improvement, be it preempt, low latency, etc.

> 	It has known costs e.g. by making the lockless 
> 		per-processor caching  more difficult if not impossible
  How much slowdown did you measure when you tested the effect of that?

> 	It seems to lead to a requirement for inheritance
  To the limited extent that I agree, so what?

> 	It has no demonstrated benefits.
  You have that backward. There are  many people who say they can see a
benefit, and no one has shown either a quantified bad impact or a single
user account which said it was worse. And I bet you looked, didn't you?

  I believe that a system will run better for a single user, and better
for a server with high interrupt rates, like DNS or web servers, where
many threads may be blocked on i/o, but there is significant CPU load as
well.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

