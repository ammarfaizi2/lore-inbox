Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135494AbRDZO0h>; Thu, 26 Apr 2001 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135491AbRDZO01>; Thu, 26 Apr 2001 10:26:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25350 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135483AbRDZO0L>;
	Thu, 26 Apr 2001 10:26:11 -0400
Date: Thu, 26 Apr 2001 11:25:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Ingo Molnar <mingo@elte.hu>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261159370.409-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104261125150.19012-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Mike Galbraith wrote:
> On Thu, 26 Apr 2001, Mike Galbraith wrote:
> 
> > > limit the runtime of refill_inactive_scan(). This is similar to Rik's
> > > reclaim-limit+aging-tuning patch to linux-mm yesterday. could you try
> > > Rik's patch with your patch except this jiffies hack, does it still
> > > achieve the same improvement?
> >
> > No.  It livelocked on me with almost all active pages exausted.
> 
> Misspoke.. I didn't try the two mixed.  Rik's patch livelocked me.

Interesting. The semantics of my patch are practically the same as
those of the stock kernel ... can you get the stock kernel to
livelock on you, too ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

