Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbRERGHZ>; Fri, 18 May 2001 02:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbRERGHQ>; Fri, 18 May 2001 02:07:16 -0400
Received: from www.wen-online.de ([212.223.88.39]:39946 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262250AbRERGG5>;
	Fri, 18 May 2001 02:06:57 -0400
Date: Fri, 18 May 2001 08:06:37 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Chris Evans <chris@scary.beasts.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.21.0105171802170.5531-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105180734360.579-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Rik van Riel wrote:

> On Thu, 17 May 2001, Mike Galbraith wrote:
>
> > > Has anyone benched 2.4.5pre3 vs 2.4.4 vs. ?
> >
> > Only doing parallel kernel builds.  Heavy load throughput is up,
> > but it swaps too heavily.  It's a little too conservative about
> > releasing cache now imho. (keeping about double what it should be
> > with this load.. easily [thump] tweaked;)
>
> "about double what it should be"
>
> That's an interesting statement, unless you have some
> arguments to define exactly how much cache the system
> should keep.

Do you think there's 60-80mb of good cachable data? ;-)  The "double"
is based upon many hundreds of test runs.  I "know" that performance
is best with this load when the cache stays around 25-35Mb.  I know
this because I've done enough bend adjusting to get throughput to
within one minute of single task times to have absolutely no doubt.
I can get it to 30 seconds with much obscene tweaking, and have done
it with zero additional overhead for make -j 30 ten times in a row.
(that kernel was.. plain weird. perfect synchronization.. voodoo!)

> Or are you just comparing with 2.2 and you'd rather
> have 2.2 performance? ;)

Nope.  I've bent this vm up a little and build kernels that kicked the
snot out of the previous record holder (classzone).  I know for a fact
that it can kick major butt.. why I fiddle with it when it doesn't.

	-Mike

