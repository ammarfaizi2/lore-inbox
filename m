Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSHXUw6>; Sat, 24 Aug 2002 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHXUw5>; Sat, 24 Aug 2002 16:52:57 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:34055 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S293680AbSHXUw5>; Sat, 24 Aug 2002 16:52:57 -0400
Date: Sat, 24 Aug 2002 17:56:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: conman@kolivas.net, <linux-kernel@vger.kernel.org>
Subject: Re: Combined performance patches update for 2.4.19
In-Reply-To: <20020824185838.2961.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.44L.0208241753490.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002, Paolo Ciarrocchi wrote:
> From: conman@kolivas.net
>
> > > Sure, but your "performance" approach is really intersting! Do you use a
> > > benchmark?
> >
> > I don't really have the time to benchmark these things any more than "it feels
> > faster". Really I'm spending way too much time on this as it is and I'm not
> > remotely any authority on what benchmarks to use.
>
> Maybe I can find the time to run a few tests, can anyone suggest me an
> "intersting" test?

Bob Matthews has a benchmark called irman, which tries to measure
response time during a number of background loads.

I'm not sure it is too interesting in this case, though. People
don't really care about the exact latency of sub-millisecond
responses (should be the vast majority) but about the few times
per minute where their mp3 skips.

Simple averages won't show the mp3 skips, because the number of
fast responses are bound to be hundreds of thousands of times
more common then the "mp3 skipping hickups".

Maybe the histogram mode of irman might show something useful ?

(then again, maybe it doesn't ... haven't tried yet)

http://people.redhat.com/bmatthews/irman/

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

