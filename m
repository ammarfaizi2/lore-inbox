Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280279AbRJaQEv>; Wed, 31 Oct 2001 11:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280247AbRJaQEi>; Wed, 31 Oct 2001 11:04:38 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34577 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280279AbRJaQEX>;
	Wed, 31 Oct 2001 11:04:23 -0500
Date: Wed, 31 Oct 2001 14:04:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
In-Reply-To: <Pine.LNX.4.33.0110310744070.32330-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0110311403440.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Linus Torvalds wrote:

> I could probably argue that the machine really _is_ out of memory at this
> point: no swap, and it obviously has to work very hard to free any pages.
> Read the "out_of_memory()" code (which is _really_ simple), with the
> realization that it only gets called when "try_to_free_pages()" fails and
> I think you'll agree.

Absolutely agreed, an earlier out_of_memory() is probably a good
thing for most systems.   The only "but" is that Lorenzo's test
program runs fine with other kernels, but you could argue that
it's a corner case anyway...

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

