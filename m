Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRDCFSF>; Tue, 3 Apr 2001 01:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRDCFRy>; Tue, 3 Apr 2001 01:17:54 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:23816 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S131392AbRDCFRo>; Tue, 3 Apr 2001 01:17:44 -0400
Message-ID: <3AC957DB.87AB1EB6@flying-brick.caverock.net.nz>
Date: Tue, 03 Apr 2001 16:55:56 +1200
From: viking <viking@flying-brick.caverock.net.nz>
Organization: The Flying Brick Computer
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: More about 2.4.3 timer problems
In-Reply-To: <Pine.LNX.4.21.0104031038070.4158-100000@brick.flying-brick.caverock.net.nz> <3AC93AE9.8AF73B94@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Eric Gillespie wrote:
> >
> >...
> > VESA fb mode 1280x1024x16, clock lost 1m 35s in time
> > ...
> > Same command, normal (non-fb mode) lost no time off clock.
>
> Is due to the 2.4.3 console drivers.  They block interrupts during
> console output.  There's a fix in 2.4.2-ac<recent>.
>
> There's also a patch against 2.4.3-pre6 at
>
>         http://www.uow.edu.au/~andrewm/linux/console.html
>
> If you'd care to test the 2.4.3-pre6 patch for a while, that'd
> be useful.
>

Cool - I'll do that - err, just one question - is a kernel-m.n-preX  a
precursor to kernel-m.n+1?
If that sentence didn't make sense, think back to algebra years.
Thanks again.

--
 /|   _,.:*^*:.,   |\           Cheers from the Viking family,
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!



