Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268041AbTCFKIU>; Thu, 6 Mar 2003 05:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTCFKIU>; Thu, 6 Mar 2003 05:08:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41965 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268033AbTCFKIT>;
	Thu, 6 Mar 2003 05:08:19 -0500
Date: Thu, 6 Mar 2003 11:18:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030306101641.GA3519@f00f.org>
Message-ID: <Pine.LNX.4.44.0303061117041.7333-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Chris Wedgwood wrote:

> > +#elif CONFIG_NR_SIBLINGS_4
> > +# define CONFIG_NR_SIBLINGS 4
> 
> There are HT chips which have 4 siblings?

not that i'm aware of - this was just there because i'm sure this thing
wont stop at 2 logical CPUs, and i wanted to add a Kconfig structure that
deals with that too. We can comment off the "CONFIG_NR_SIBLINGS 4" line
from the Kconfig, for now.

	Ingo

