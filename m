Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSIWONR>; Mon, 23 Sep 2002 10:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSIWONQ>; Mon, 23 Sep 2002 10:13:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57019 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261619AbSIWONQ>;
	Mon, 23 Sep 2002 10:13:16 -0400
Date: Mon, 23 Sep 2002 16:26:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, <gcc@gcc.gnu.org>
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <1032777021.3d8eed3d55f53@kolivas.net>
Message-ID: <Pine.LNX.4.44.0209231622100.23588-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Con Kolivas wrote:

> Agreed. There probably is no statistically significant difference in the
> different gcc versions.
> 
> Contest is very new and I appreciate any feedback I can get to make it
> as worthwhile a benchmark as possible to those who know.

your measurements are really useful i think, and people like Andrew
started to watch those numbers - this is why at this point a bit more
effort can/should be taken to filter out fluctuations better. Ie. a single
fluctuation could send Andrew out on a wild goose chase while perhaps in
reality his kernel was the fastest. Running every test twice should at
least give a ballpart figure wrt. fluctuations, without increasing the
runtime unrealistically.

i agree that only the IO benchmarks are problematic from this POV - things
like the process load and your other CPU-saturating numbers look perfectly
valid.

obviously another concern to to make testing not take days to accomplish.  
This i think is one of the hardest things - making timely measurements
which are still meaningful and provide stable results.

	Ingo

