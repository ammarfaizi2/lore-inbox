Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286399AbRL0Rp7>; Thu, 27 Dec 2001 12:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286394AbRL0Rpx>; Thu, 27 Dec 2001 12:45:53 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:18950 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286390AbRL0Rox>; Thu, 27 Dec 2001 12:44:53 -0500
Date: Thu, 27 Dec 2001 09:48:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Victor Yodaiken <yodaiken@fsmlabs.com>
cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <20011226204215.A1007@hq2>
Message-ID: <Pine.LNX.4.40.0112270944450.1558-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001, Victor Yodaiken wrote:

> On Sun, Dec 23, 2001 at 05:20:26PM -0800, Davide Libenzi wrote:
> > On Sun, 23 Dec 2001, Victor Yodaiken wrote:
> >
> > > On Thu, Dec 20, 2001 at 02:36:07PM -0800, Davide Libenzi wrote:
> > > > > My understanding of the POSIX standard is the the highest priority
> > > > > task(s) are to get the cpu(s) using the standard calls.  If you want to
> > > > > deviate from this I think the standard allows extensions, but they IMHO
> > > > > should be requested, not the default, so I would turn your flag around
> > > > > to force LOCAL, not GLOBAL.
> > > >
> > > > So, you're basically saying that for a better standard compliancy it's
> > > > better to have global preemption policy by default. And having users to
> > > > request rt tasks localization explicitly. It's fine for me.
> > >
> > > Can you please cite the passaaages in the standrd you have in mind?
> >
> > POSIX 1003. The doubt was if ( since the POSIX standard does not talk
> > about SMP ) the real time priorities apply to CPU or to the entire system.
>
> Right, that was my question. George says, in your words, "for better
> standards compliancy ..." and I want to know why you guys think that.

The thought was that if someone need RT tasks he probably need a very low
latency and so the idea that by applying global preemption decisions would
lead to a better compliancy. But i'll be happy to ear that this is false
anyway ...




- Davide


