Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbTBADMC>; Fri, 31 Jan 2003 22:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBADMB>; Fri, 31 Jan 2003 22:12:01 -0500
Received: from mail021.syd.optusnet.com.au ([210.49.20.161]:40852 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S264702AbTBADMB> convert rfc822-to-8bit; Fri, 31 Jan 2003 22:12:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
Date: Sat, 1 Feb 2003 14:21:16 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
References: <200302010930.54538.conman@kolivas.net> <200302011209.49692.conman@kolivas.net> <3E3B2187.1000203@cyberone.com.au>
In-Reply-To: <3E3B2187.1000203@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302011421.17044.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >I found the following is how loads occur almost always:
> >noload time: 60
> >load time kernal a: 80, loads 20
> >load time kernel b: 100, loads 40
> >load time kernel c: 90, loads 30
> >
> >and loads/total time wouldnt show this effect as kernel c would appear to
> > have a better load rate
>
> Kernel a would have a rate of .25 l/s, b: .4 l/s, c: .33~ l/s so I b would
> be better.

Err yeah thats what I mean sorry. What I'm getting at is notice they all do it 
at 1/second regardless. It's only the scheduling balance that has changed 
rather than the rate of work.

> >if there was
> >load time kernel d: 80, loads 40
> >
> >that would be more significant no?
>
> It would, yes... but it would measure .5 loads per second done.
>
> The noload time is basically constant anyway so I don't think it would add
> much value if it were incorporated into the results, but would make the
> metric harder to follow than simple "loads per second".

At the moment total loads tells the full story either way so for now I'm 
sticking to that.

Con
