Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263949AbRFRNhu>; Mon, 18 Jun 2001 09:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263945AbRFRNhk>; Mon, 18 Jun 2001 09:37:40 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49937 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263944AbRFRNha>;
	Mon, 18 Jun 2001 09:37:30 -0400
Date: Mon, 18 Jun 2001 10:37:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: German Gomez Garcia <german@piraos.com>
Cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.33.0106181150320.11843-100000@hal9000.piraos.com>
Message-ID: <Pine.LNX.4.21.0106181036150.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, German Gomez Garcia wrote:

> 	I've running 2.4.5-ac15 for almost a day (22 hours) and I found
> some strange behaviour of the kswap, at least it was not present in
> 2.4.5-ac9. The swap memory increase with time as the cache dedicated
> memory also increase, that is swapping process at a very fast rate, even
> when no program is getting more memory. Is that the expected behaviour?

Yes, this is expected behaviour with -ac14, -pre3 and newer.

Note that the memory isn't actually swapped out. It's still
sitting in RAM, being counted as swap cache (and because of
this showing up as "cache" in top).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

