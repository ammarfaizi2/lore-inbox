Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSIEN2p>; Thu, 5 Sep 2002 09:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSIEN2p>; Thu, 5 Sep 2002 09:28:45 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:60099 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317489AbSIEN2o>; Thu, 5 Sep 2002 09:28:44 -0400
Date: Thu, 5 Sep 2002 10:33:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Race in shrink_cache
In-Reply-To: <E17mqFV-00065Y-00@starship>
Message-ID: <Pine.LNX.4.44L.0209051032530.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Daniel Phillips wrote:

> /*
>  * We must not allow an anon page
>  * with no buffers to be visible on
>  * the LRU, so we unlock the page after
>  * taking the lru lock
>  */
>
> That is, what's scary about an anon page without buffers?

Nothing, those are placed on the LRU all the time.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

