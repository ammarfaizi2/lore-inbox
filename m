Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSH0AJz>; Mon, 26 Aug 2002 20:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSH0AJz>; Mon, 26 Aug 2002 20:09:55 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:63413 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318151AbSH0AJy>; Mon, 26 Aug 2002 20:09:54 -0400
Date: Mon, 26 Aug 2002 21:13:38 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: Ed Tomlinson <tomlins@cam.org>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Daniel Phillips <phillips@arcor.de>
Subject: Re: MM patches against 2.5.31
In-Reply-To: <3D6AC0BB.FE65D5F7@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0208262113070.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Andrew Morton wrote:

> Well we wouldn't want to leave tons of free pages on the LRU - the VM
> would needlessly reclaim pagecache before finding the free pages.  And
> higher-order page allocations could suffer.

We did this with the swap cache in 2.4.<7 and it was an
absolute disaster.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

