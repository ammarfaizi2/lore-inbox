Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288623AbSAXQAO>; Thu, 24 Jan 2002 11:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSAXQAC>; Thu, 24 Jan 2002 11:00:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10178 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288606AbSAXP77>;
	Thu, 24 Jan 2002 10:59:59 -0500
Date: Thu, 24 Jan 2002 18:57:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preemptive kernel
In-Reply-To: <20020124155557.GM1816@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201241857100.2050-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Jan 2002, Tom Rini wrote:

> > can you please redo for O(1)-J6 (2.4.18-pre7) or is nothing changed?
>
> Or -J6 there was a small reject, it looks like -J6 sets p->cpu =
> smp_processor_id(); in kernel/sched.c, which the preempt patch wants to
> do as well.

it's the same fix - you can safely disregard the reject.

	Ingo

