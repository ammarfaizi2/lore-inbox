Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRIFNFt>; Thu, 6 Sep 2001 09:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRIFNFj>; Thu, 6 Sep 2001 09:05:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26888 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270257AbRIFNFZ>;
	Thu, 6 Sep 2001 09:05:25 -0400
Date: Thu, 6 Sep 2001 10:05:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <_deepfire@mail.ru>, <linux-kernel@vger.kernel.org>,
        <marcelo@conectiva.com.br>
Subject: Re: page pre-swapping + moving it on cache-list
In-Reply-To: <20010906145152.5b229174.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0109061003320.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Stephan von Krawczynski wrote:

> What's the use of an inactive_clean list anyway, or the effective
> difference between its members and the members of memfree (I suspect
> such a list from the output of /proc/meminfo)?

Pages on the inactive_clean list contain data. Throwing
away data when you can keep it in memory isn't the smartest
thing.

> Besides the fact, that the splitting in two lists prevents proper
> defragmentation

Patches to fix this thing while still allowing us to keep
the data in memory for most pages are appreciated. Patches
to the universe to give me more than 24 hours a day, too ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

