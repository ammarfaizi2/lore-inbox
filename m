Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSHXMR2>; Sat, 24 Aug 2002 08:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSHXMR2>; Sat, 24 Aug 2002 08:17:28 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:33985 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315923AbSHXMR1>;
	Sat, 24 Aug 2002 08:17:27 -0400
Message-ID: <1030191697.3d677a510d30b@kolivas.net>
Date: Sat, 24 Aug 2002 22:21:37 +1000
From: conman@kolivas.net
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: Combined performance patches update for 2.4.19
References: <20020824120208.30967.qmail@linuxmail.org>
In-Reply-To: <20020824120208.30967.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> > > note: consoletype[499] exited with preempt_count 1
> > 
> > Yes if you read my FAQ you'd see this is a known issue. I need some higher
> help
> > to sort this out
> OK, did you contact Robert Love?

No I don't really want to bother the real developers because they are doing real
work. What I'm doing could almost be called butchering, but it definitely gave
me a performance advantage and seemed a shame to not share the work given the
effort I put in.

> > > BTW, thank you for your great work!!
> > 
> > My pleasure, but really the hard work is done by the developers!
> Sure, but your "performance" approach is really intersting! Do you use a
> benchmark?

I don't really have the time to benchmark these things any more than "it feels
faster". Really I'm spending way too much time on this as it is and I'm not
remotely any authority on what benchmarks to use.

> > > I'm also testing the compressed cache (the 
> > > patch you've discarded, and I got good performance!)
> > 
> > I'm thinking of eventually merging the latest version of this into 2.4.19
> too
> > since it can be enabled or disabled. Depends on the demand.
> Just an hint ('cause I made some of the test you can see on the compressed
> cache web page on sourceforge),
> if you use that patch boot your box with the 
> compressed=XXM in order to set the amount of the compressed cache. My box
> runs fast and happy with 32MiB or 64MiB of compressed cache. My box has
> 256MiB of Ram.

Ok thanks for the info. I believe the newer cc patch (not in my 2.4.18-ck4) is
better anyway. I'm afraid the cc will be later in the piece assuming I can kill
off the other bug I've created in the merge. I'd prefer to see a cc patch
specifically for 2.4.19 as forward porting it to .19 and then to O(1) (and so
on) are just too many steps. 

Cheers,
Con Kolivas
