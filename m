Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSLIMTm>; Mon, 9 Dec 2002 07:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbSLIMTm>; Mon, 9 Dec 2002 07:19:42 -0500
Received: from 5-048.ctame701-1.telepar.net.br ([200.193.163.48]:27359 "EHLO
	5-048.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265333AbSLIMTl>; Mon, 9 Dec 2002 07:19:41 -0500
Date: Mon, 9 Dec 2002 10:27:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>
Subject: Re: [TRIVIAL] Re: setrlimit incorrectly allows hard limits to exceed
 soft limits
In-Reply-To: <15860.1070.521840.791396@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.50L.0212091026410.21756-100000@imladris.surriel.com>
References: <15860.1070.521840.791396@wombat.chubb.wattle.id.au>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, Peter Chubb wrote:

> Rik> Wouldn't it be better to simply take the soft limit down to
> Rik> min(new_rlim.rlim_cur, new_rlim.rlim_max) ?
>
> Single unix spec says to return EINVAL in this case.
>
> [EINVAL]
> An invalid resource was specified; or in a setrlimit() call, the new
> rlim_cur exceeds the new rlim_max.

So how about "the old rlim_cur exceeds the new rlim_max" ? ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
