Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261923AbSIWObN>; Mon, 23 Sep 2002 10:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbSIWObN>; Mon, 23 Sep 2002 10:31:13 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:35985 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261923AbSIWObM>;
	Mon, 23 Sep 2002 10:31:12 -0400
Message-ID: <1032791781.3d8f26e5c7a05@kolivas.net>
Date: Tue, 24 Sep 2002 00:36:21 +1000
From: Con Kolivas <conman@kolivas.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.4.44.0209231622100.23588-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209231622100.23588-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ingo Molnar <mingo@elte.hu>:

> 
> On Mon, 23 Sep 2002, Con Kolivas wrote:
> 
> > Agreed. There probably is no statistically significant difference in the
> > different gcc versions.
> > 
> > Contest is very new and I appreciate any feedback I can get to make it
> > as worthwhile a benchmark as possible to those who know.
> 
> your measurements are really useful i think, and people like Andrew

Thank you. I was beginning to wonder on this.

> started to watch those numbers - this is why at this point a bit more
> effort can/should be taken to filter out fluctuations better. Ie. a single
> fluctuation could send Andrew out on a wild goose chase while perhaps in
> reality his kernel was the fastest. Running every test twice should at
> least give a ballpart figure wrt. fluctuations, without increasing the
> runtime unrealistically.

Absolutely. In my real profession I deal with statistics all the time so I'm
acutely aware of the problem.

> i agree that only the IO benchmarks are problematic from this POV - things
> like the process load and your other CPU-saturating numbers look perfectly
> valid.

Yes, the IO load is proving to be a pain and I'm afraid it will take numerous
measurements to get some idea of the real average. So far the trends in the
results I've reported I think are still correct. The variability, though, that's
another matter.

> obviously another concern to to make testing not take days to accomplish.  
> This i think is one of the hardest things - making timely measurements
> which are still meaningful and provide stable results.

I know. Some of the changes I've made to make results reproducible I have
already had complaints about; the situation will only get worse :(

Con
