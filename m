Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRIPRAS>; Sun, 16 Sep 2001 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272547AbRIPRAJ>; Sun, 16 Sep 2001 13:00:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64009 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272560AbRIPQ76>;
	Sun, 16 Sep 2001 12:59:58 -0400
Date: Sun, 16 Sep 2001 14:00:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre7aa1
In-Reply-To: <20010910210607.C715@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109161359040.9536-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001, Andrea Arcangeli wrote:

> > My problem with this appropech is just that we use kernel threads for
> > more and more stuff - always creating new ones.  I think at some point
> > they will sum up badly.
>
> They almost only costs memory. I also don't like unnecessary kernel
> threads but I can see usefulness for this one, OTOH as you said the
> latency of the wait_for_rcu isn't very critical but usually I prefer to
> save cycles with memory where I can and where it's even cleaner to do so.

I can't quite remember if it was Linus or Larry who said:

"Threads are for people who don't understand state machines"


If you cannot make your code clean without adding another
thread, it's probably a bad sign ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

