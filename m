Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313682AbSDPRLB>; Tue, 16 Apr 2002 13:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313686AbSDPRLA>; Tue, 16 Apr 2002 13:11:00 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:7319 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S313682AbSDPRK6>; Tue, 16 Apr 2002 13:10:58 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 16 Apr 2002 10:18:18 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: davidm@hpl.hp.com
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <15548.22093.57788.557129@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0204161013050.1460-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, David Mosberger wrote:

> >>>>> On Tue, 16 Apr 2002 16:27:12 +0000 (UTC), torvalds@transmeta.com (Linus Torvalds) said:
>
>   Linus> And I've had some Intel people grumble about it, because it
>   Linus> apparently means that the timer tick takes anything from 2%
>   Linus> to an extreme of 10% (!!) of the CPU time under certain
>   Linus> loads.
>
> I'm not sure I believe this.  I have had occasional cases where I
> wondered whether the timer tick caused significant overhead, but it
> always turned out to be something else.  In my measurements,
> *user-level* profiling has the 2-10% overhead you're mentioning, but
> that's with a signal delivered to user level on each tick.

i still have pieces of paper on my desk about tests done on my dual piii
where by hacking HZ to 1000 the kernel build time went from an average of
2min:30sec to an average 2min:43sec. that is pretty close to 10%



- Davide


