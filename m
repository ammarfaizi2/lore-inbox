Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbRFLSRk>; Tue, 12 Jun 2001 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbRFLSR3>; Tue, 12 Jun 2001 14:17:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:8461 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262982AbRFLSRT>;
	Tue, 12 Jun 2001 14:17:19 -0400
Date: Tue, 12 Jun 2001 15:16:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Rob Landley <landley@webofficenow.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Nelson <mnelson@dynatec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Any limitations on bigmem usage?
In-Reply-To: <01061208465701.00814@webofficenow.com>
Message-ID: <Pine.LNX.4.21.0106121514300.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Rob Landley wrote:

> Brilliant.  You need what, a 6x larger cache just to break even with
> the amount of time you're running in-cache? 

That's going to be hard, since the cache will also need to be
faster in order to feed the CPU core.  Making a cache both
larger AND faster at the same time will need some smart people.

> And of course the compiler is GOING to put NOPs in that because it
> won't always be able to figure out something for the second and third
> cores to do this clock, regardless of how good a compiler it is.  

Compilers are also notoriously bad at runtime optimisations.

> That's just beautiful.

I also never expected Intel to dispose of themselves in such
a cute way.

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

