Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSDXURF>; Wed, 24 Apr 2002 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDXURE>; Wed, 24 Apr 2002 16:17:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58636 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293457AbSDXURD>;
	Wed, 24 Apr 2002 16:17:03 -0400
Date: Wed, 24 Apr 2002 17:16:35 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] page->flags cleanup
In-Reply-To: <3CC6720F.BD1367B9@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0204241710590.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Andrew Morton wrote:

> Moves the definitions of the page->flags bits and all the PageFoo
> macros into linux/page-flags.h.  That file is currently included from
> mm.h, but the stage is set to remove that and include page-flags.h
> direct in all .c files which require that.  (120 of them).

I like this patch a lot.  It's definately the right time to
clean up some of the years old cruft.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


