Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318190AbSIBBEr>; Sun, 1 Sep 2002 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSIBBEq>; Sun, 1 Sep 2002 21:04:46 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:9105 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318190AbSIBBEq>; Sun, 1 Sep 2002 21:04:46 -0400
Date: Sun, 1 Sep 2002 22:08:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Include LRU in page count
In-Reply-To: <E17leDK-0004dA-00@starship>
Message-ID: <Pine.LNX.4.44L.0209012208350.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Daniel Phillips wrote:

> Are we looking at the same thing?  The cpu load there is dominated by
> cpu_idle, 89%.  Anyway, if your point is that it makes sense to run
> shrink_cache or refill_inactive in parallel, I don't see it because
> they'll serialize on the lru lock anyway.  What would make sense is to
> make shink_cache nonblocking.

Working on it ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

