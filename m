Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSC2XPD>; Fri, 29 Mar 2002 18:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312304AbSC2XOy>; Fri, 29 Mar 2002 18:14:54 -0500
Received: from [195.39.17.254] ([195.39.17.254]:53639 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312302AbSC2XOq>;
	Fri, 29 Mar 2002 18:14:46 -0500
Date: Sat, 30 Mar 2002 00:07:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
Message-ID: <20020329230745.GD9974@elf.ucw.cz>
In-Reply-To: <E16qHy4-0005l7-00@the-village.bc.nu> <Pine.GSO.3.96.1020328133623.11187A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >  How can't it be critical?  Your system is overheating.  It is about to
> > > fail -- depending on the configuration, it'll either crash or be shut down
> > 
> > Neither. It will drop to a much lower clock speed. You can set it to overheat
> > and blow up but thats a mostly undocumented mtrr 8) The default behaviour is
> > to throttle back hard
> 
>  Depending on the reason of an overheat condition this may circumvent the
> problem or not.  As I already stated you may have fire in the room (and
> not all computer rooms seem to have automatic extinguishing systems). 
> Hardware failures are not to be treated lightly. 

Overheat is not neccessarily hardware failure.

You see, I have a notebook. I put pen in it to stop the fan. Hardware
is pretty much okay, but, well, pen does not allow fan to spin.

What's the best behaviour? Throttle is okay.

I take the same notebook, let it compile kernel, put it into my bed,
and cover it. What should happen? Throttle is okay. I'll get warm bed
and compiled kernel.

Is there something better you propose notebook to do.

And now, you have fire at server room. All cpus throtle, then are
burn. Does it matter if they throttled? No.

And now, you have your must-be-running server at university. Its fan
fails. What do you want it to do? Throttle is the best thing. (It
might deliver mail slightly slower, but it can probably handle load
during the night so I can get there).

So it seems to me throttle is always right answer.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
