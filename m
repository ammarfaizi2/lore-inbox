Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSIWNW6>; Mon, 23 Sep 2002 09:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSIWNW5>; Mon, 23 Sep 2002 09:22:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2999 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261393AbSIWNWa>;
	Mon, 23 Sep 2002 09:22:30 -0400
Date: Mon, 23 Sep 2002 15:35:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Erik Andersen <andersen@codepoet.org>, Con Kolivas <conman@kolivas.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <Pine.LNX.3.95.1020923091213.2963C-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0209231533570.22336-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Richard B. Johnson wrote:

> > It would sure be nice for this sortof test if there were
> > some sort of a "flush-all-caches" syscall...
> 
> I think all you need to do is reload the code-segment register
> and you end up flushing caches in ix86.

i'm pretty sure what was meant was the flushing of the pagecache mainly.
The state of CPU caches does not really play in these several-minutes
benchmarks, they are at most a few millisecs worth of CPU time to build.

	Ingo

