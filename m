Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288649AbSAXQIN>; Thu, 24 Jan 2002 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288655AbSAXQH6>; Thu, 24 Jan 2002 11:07:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37826 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288649AbSAXQHL>;
	Thu, 24 Jan 2002 11:07:11 -0500
Date: Thu, 24 Jan 2002 19:04:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preemptive kernel
In-Reply-To: <20020124160540.GO1816@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201241904310.2523-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Tom Rini wrote:

> > > Or -J6 there was a small reject, it looks like -J6 sets p->cpu =
> > > smp_processor_id(); in kernel/sched.c, which the preempt patch wants to
> > > do as well.
> >
> > it's the same fix - you can safely disregard the reject.
>
> If you apply -J6 after.  preempt adds preempt_enable() in the same
> section.

right.

	Ingo

