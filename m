Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbSAHAhK>; Mon, 7 Jan 2002 19:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSAHAhC>; Mon, 7 Jan 2002 19:37:02 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53254 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287508AbSAHAgt>;
	Mon, 7 Jan 2002 19:36:49 -0500
Date: Mon, 7 Jan 2002 22:36:29 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: <brownfld@irridia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020107152020.6e8d07a4.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0201072211440.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Stephan von Krawczynski wrote:

> > To be clear ... -aa and -rmap should of course also work
> > nicely without swap, no excuses for the bad behaviour
> > shown in Martin's test, but at the moment they simply
> > don't seem tuned for it.
>
> Good to hear we agree it _should_ work. When does it (rmap)?
> ;-)

I integrated Ed Tomlinson's patch today and have made
one more small change. In the patches I ran here things
worked fine, the system avoids OOM now.

Problem is, it doesn't seem to want to run the OOM
killer when needed, at least not any time soon. I need
to check out this code again later.

Anyway, rmap-11 should work fine for your test. ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

