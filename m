Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288571AbSADJrw>; Fri, 4 Jan 2002 04:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288572AbSADJrm>; Fri, 4 Jan 2002 04:47:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18567 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288571AbSADJre>;
	Fri, 4 Jan 2002 04:47:34 -0500
Date: Fri, 4 Jan 2002 12:44:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: David Lang <david.lang@digitalinsight.com>
Cc: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201040000070.18636-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.33.0201041242500.2247-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, David Lang wrote:

> Ingo,
> back in the 2.4.4-2.4.5 days when we experimented with the
> child-runs-first scheduling patch we ran into quite a few programs that
> died or locked up due to this. (I had a couple myself and heard of others)

hm, Andrea said that the only serious issue was in the sysvinit code,
which should be fixed in any recent distro. Andrea?

> try switching this back to the current behaviour and see if the
> lockups still happen.

there must be some other bug as well, the child-runs-first scheduling can
cause lockups, but it shouldnt cause oopes.

	Ingo

