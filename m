Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbRGJX1r>; Tue, 10 Jul 2001 19:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbRGJX1h>; Tue, 10 Jul 2001 19:27:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40207 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267172AbRGJX1W>;
	Tue, 10 Jul 2001 19:27:22 -0400
Date: Tue, 10 Jul 2001 20:27:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Dirk Wetter <dirkw@rentec.com>
Cc: Wayne Whitney <whitney@math.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: dead mem pages 
In-Reply-To: <Pine.LNX.4.33.0107101321000.25541-100000@monster000.rentec.com>
Message-ID: <Pine.LNX.4.33L.0107102013560.2836-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Dirk Wetter wrote:

> > It would be good to know what these 2.8GB of cached pages are.
>
> believe me, i would like to know too where all the $$$ memory
> went to. ;-)

Most likely swap cache, that means it is the memory from your
simulations, just removed from the page tables and put in the
swap cache.

> > Again on a general note, the 2.4 kernel's VM is new and hence not fully
> > mature.  So the short and unhelpful answer to your query is probably that
> > the current VM system is not well tuned for your workload (4.3GB of memory
> > hungry simulations on a 4GB machine).
>
> concerning the maturity that's also the answer i got from the kernel
> guru's at last USENIX in boston. but ihmo it *should* become soon
> better for the future if Linux intends to become bigger in the server
> business. (my $0.02)

It'll get better as soon as we have the time, for 2.4.7
the VM statistics have already improved a bit so people
are no longer fooled by large "cached" figures ;)

Actual improvements to the code, if needed at all, will
come with time ... more than $0.02 will get you ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

