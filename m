Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145107AbRA2Dsv>; Sun, 28 Jan 2001 22:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145106AbRA2Dsl>; Sun, 28 Jan 2001 22:48:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40456 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S145105AbRA2Dsc>;
	Sun, 28 Jan 2001 22:48:32 -0500
Message-ID: <3A74E7FE.D0EFDA06@mandrakesoft.com>
Date: Sun, 28 Jan 2001 22:48:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: drew@drewb.com
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Dieter Nützel" <Dieter.Nuetzel@hamburg.de>,
        Andrew Grover <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
		<3A7494B1.70799C19@mandrakesoft.com>
		<14964.41681.126496.746739@champ.drew.net> <14964.44473.518811.451472@champ.drew.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Bertola wrote:
> 
> Drew Bertola writes:
> > Andrew's latest ACPI fixes (acpica-linux-20000125 patched against
> > 2.4.0) compile fine here and don't hang on my Vaio after loading
> > tables.
> >
> > That's a start.  I'll play around some more.
> 
> Unfortunately, pcmcia modules fail to load.  I can't understand the
> interaction.
> 
> The message displayed on boot when starting the service says:
> 
> ds: no socket drivers loaded

Personally I advocate building all pcmcia stuff into the kernel.  It has
never failed before, and its core hardware on your laptop, so it will
always be there.  Why bother with modules at all for core
functionality...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
