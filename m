Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbRESVnA>; Sat, 19 May 2001 17:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbRESVmu>; Sat, 19 May 2001 17:42:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25096 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261355AbRESVmi>;
	Sat, 19 May 2001 17:42:38 -0400
Date: Sat, 19 May 2001 18:41:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105191743000.393-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105191840250.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, Mike Galbraith wrote:
> On Fri, 18 May 2001, Stephen C. Tweedie wrote:
> 
> > That's the main problem with static parameters.  The problem you are
> > trying to solve is fundamentally dynamic in most cases (which is also
> > why magic numbers tend to suck in the VM.)
> 
> Magic numbers might be sucking some performance right now ;-)

... so you replace them with some others ... ;)

> Three back to back make -j 30 runs for three different kernels.
> Swap cache numbers are taken immediately after last completion.

The performance increase is nice, though.  Do you see similar
changes in different kinds of workloads ?


> (yes, the last hunk looks out of place wrt my text.

It also looks kind of bogus and geared completely towards this
particular workload ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

