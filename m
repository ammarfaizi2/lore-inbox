Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSGVNl7>; Mon, 22 Jul 2002 09:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGVNl7>; Mon, 22 Jul 2002 09:41:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:63494 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317263AbSGVNl6>; Mon, 22 Jul 2002 09:41:58 -0400
Date: Mon, 22 Jul 2002 10:44:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
In-Reply-To: <Pine.LNX.4.44L.0207221029590.3086-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44L.0207221043050.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Rik van Riel wrote:

> Apart from both of these we'll also need code to garbage collect
> empty page tables so users can't clog up memory by mmaping a page
> every 4 MB ;)

Btw, I've started work on this code already.

Putting the dcache/icache pages on the LRU list in the way
Linus wanted is definately a lower priority thing for me at
this point, especially considering the fact that Ed Tomlinson's
way of having these pages on the LRU seems to work just fine ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

