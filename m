Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRIFL3S>; Thu, 6 Sep 2001 07:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272450AbRIFL3I>; Thu, 6 Sep 2001 07:29:08 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47633 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270309AbRIFL27>;
	Thu, 6 Sep 2001 07:28:59 -0400
Date: Thu, 6 Sep 2001 08:29:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: page pre-swapping + moving it on cache-list
In-Reply-To: <200109060519.f865Ja106488@vegae.deep.net>
Message-ID: <Pine.LNX.4.33L.0109060828420.31200-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Samium Gromoff wrote:

>        Here is an idea i think i stole from Matthew Dillon`s paper.
>
>     Actually it sound more like we take some pages from the near 0
>   age and swapping them out but not throwing them away, but moving them
>   from active list to cache. So that we can always throw them away
>   at near null cost while shrinking the cache. This is like a
>   replacement for swap-cache if i`m right here...

This is called the "inactive_clean" list in Linux terminology. ;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

