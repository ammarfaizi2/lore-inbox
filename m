Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269638AbRHCWI3>; Fri, 3 Aug 2001 18:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269639AbRHCWIT>; Fri, 3 Aug 2001 18:08:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:54276 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269638AbRHCWIN>;
	Fri, 3 Aug 2001 18:08:13 -0400
Date: Fri, 3 Aug 2001 19:08:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Mike Black <mblack@csihq.com>
Cc: David Ford <david@blue-labs.org>, "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com>
Message-ID: <Pine.LNX.4.33L.0108031907220.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Mike Black wrote:

> Couldn't kswapd just gracefully back-off when it doesn't make any
> progress? In my case (with ext3/raid5 and a tiobench test) kswapd
> NEVER actually swaps anything out. It just chews CPU time.

> So...if kswapd just said "didn't make any progress...*2 last sleep" so
> it would degrade itself.

It wouldn't just degrade itself.

It would also prevent other programs in the system
from allocating memory, effectively halting anybody
wanting to allocate memory.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

