Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280342AbRJaR2M>; Wed, 31 Oct 2001 12:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280343AbRJaR2I>; Wed, 31 Oct 2001 12:28:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:25095 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280342AbRJaR1J>;
	Wed, 31 Oct 2001 12:27:09 -0500
Date: Wed, 31 Oct 2001 15:27:31 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Timur Tabi <ttabi@interactivesi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Module Licensing?
In-Reply-To: <20011031092228.J1506@work.bitmover.com>
Message-ID: <Pine.LNX.4.33L.0110311525460.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Larry McVoy wrote:

> > Since your program, which happens to consist of one open
> > source part and one proprietary part, is partly a derived
> > work from the kernel source (by using kernel header files
> > and the inline functions in it) your whole work must be
> > distributed under the GPL.
>
> This is obviously incorrect, that would say that
>
> 	#include <sys/types.h>
>
> means my app is now GPLed.  Good luck enforcing that.

You're right, just including <sys/types.h> won't do that,
but either of:

1) using inline functions from a .h file  or
2) linking to the library/kernel later on

might mean your stuff is GPLed.

Be careful which definitions you get from the
header file, inline functions are a very grey
area ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

