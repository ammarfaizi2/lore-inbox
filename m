Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSAXQGx>; Thu, 24 Jan 2002 11:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288645AbSAXQGl>; Thu, 24 Jan 2002 11:06:41 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:25988
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S288639AbSAXQGQ>; Thu, 24 Jan 2002 11:06:16 -0500
Date: Thu, 24 Jan 2002 09:05:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] preemptive kernel
Message-ID: <20020124160540.GO1816@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020124155557.GM1816@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0201241857100.2050-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201241857100.2050-100000@localhost.localdomain>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2002 at 06:57:27PM +0100, Ingo Molnar wrote:
> 
> On Thu, 24 Jan 2002, Tom Rini wrote:
> 
> > > can you please redo for O(1)-J6 (2.4.18-pre7) or is nothing changed?
> >
> > Or -J6 there was a small reject, it looks like -J6 sets p->cpu =
> > smp_processor_id(); in kernel/sched.c, which the preempt patch wants to
> > do as well.
> 
> it's the same fix - you can safely disregard the reject.

If you apply -J6 after.  preempt adds preempt_enable() in the same
section.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
