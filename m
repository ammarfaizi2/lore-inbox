Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSJIJRa>; Wed, 9 Oct 2002 05:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJIJRa>; Wed, 9 Oct 2002 05:17:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29910 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261223AbSJIJR3>;
	Wed, 9 Oct 2002 05:17:29 -0400
Date: Wed, 9 Oct 2002 11:32:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [ANNOUNCE] nptl 0.2
In-Reply-To: <20021004151054.GA1752@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0210091120510.18357-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, J.A. Magallon wrote:

> Problem is kernel 2.5. Too 'risky'. I would like to ask again: could you
> state what new kernel features are needed (futexes, cpu-affinity
> syscalls, signalling changes...). Perhaps people can use 2.4 -ac or -aa
> trees (if for example nptl only needs futexes).

too many to list, really. It's more than 60 separate patches that went
into 2.5 in the past 2 months that implement all the necessery
infrastructure for NPTL-style 1:1 threading. Futexes had to be fixed too,
so it's not like you could use the existing 2.4 futex patch for NPTL. I'll
attempt a 2.4 backport of all the threading bits within the next couple of
weeks, but it's not a matter of a couple of hours ...

but, 2.5 isnt all that bad these days, and Arjan is currently working on
2.5 kernel rpms, to make it even easier to try out. (it will be announced
to phil-list once he's done.)

	Ingo

