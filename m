Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319516AbSIGUWu>; Sat, 7 Sep 2002 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319517AbSIGUWu>; Sat, 7 Sep 2002 16:22:50 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:29089 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319516AbSIGUWt>; Sat, 7 Sep 2002 16:22:49 -0400
Date: Sat, 7 Sep 2002 17:27:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Lars Marowsky-Bree <lmb@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [lmb@suse.de: Re: [RFC] mount flag "direct" (fwd)]
In-Reply-To: <200209071959.g87JxKN17732@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209071723200.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2002, Peter T. Breuer wrote:

> > Noone appreciates reinventing the wheel another time, especially if - for
> > simplification - it starts out as a square.
>
> But what I suggest is finding a simple way to turn an existing FS into a
> distributed one. I.e. NOT reinventing the wheel. All those other people
> are reinventing a wheel, for some reason :-).

To stick with the wheel analogy, while bicycle wheels will
fit on a 40-tonne truck, they won't even get you out of the
parking lot.

> > You tell me why Distributed Filesystems are important. I fully agree.
> >
> > You fail to give a convincing reason why that must be made to work with
> > "all" conventional filesystems, especially given the constraints this implies.
>
> Because that's the simplest thing to do.

You've already admitted that you would need to modify the
existing filesystems in order to create "filesystem independant"
clustered filesystem functionality.

If you're modifying filesystems, surely it no longer is filesystem
independant and you might as well design your filesystem so it can
do clustering in an _efficient_ way.

> > What you are starting would need at least 3-5 years to catch up with what
> > people currently already can do, and they'll improve in this time too.
>
> Maybe 3-4 weeks more like. The discussion is helping me get a picture,
> and when I'm back next week I'll try something. Then, unfortunately I
> am away again from the 18th ...

If you'd only spent 3-4 _days_ looking at clustered filesystems
you would see that it'd take months or years to get something
work decently.


> No features. Just take any FS that corrently works, and see if you can
> distribute it.  Get rid of all fancy features along the way.  You mean
> "what's wrong with X"?  Well, it won't be mainstream, for a start, and
> that's surely enough.  The projects involved are huge, and they need to
> minimize risk, and maximize flexibility. This is CERN, by the way.

All you can hope for now is that CERN doesn't care about data
integrity or performance ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

