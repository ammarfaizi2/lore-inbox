Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKPV53>; Thu, 16 Nov 2000 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbQKPV5T>; Thu, 16 Nov 2000 16:57:19 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:33801 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129874AbQKPV5D>;
	Thu, 16 Nov 2000 16:57:03 -0500
To: pavel@suse.cz
CC: jgarzik@mandrakesoft.com, dwmw2@infradead.org, dhinds@valinux.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, tutso@mit.edu
In-Reply-To: <20000101025452.A53@toy> (message from Pavel Machek on Sat, 1 Jan
	2000 02:54:52 +0000)
Subject: Re: [PATCH] pcmcia event thread. (fwd)
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <Pine.LNX.4.30.0011132222070.28525-100000@imladris.demon.co.uk> <3A106F81.FB5BE7F1@mandrakesoft.com> <20000101025452.A53@toy>
Message-Id: <E13wWYG-00047b-00@beefcake.hdqt.valinux.com>
Date: Thu, 16 Nov 2000 13:26:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 1 Jan 2000 02:54:52 +0000
   From: Pavel Machek <pavel@suse.cz>
   Cc: David Woodhouse <dwmw2@infradead.org>, David Hinds <dhinds@valinux.com>,
	   torvalds@transmeta.com, tytso@valinux.com,
	   linux-kernel@vger.kernel.org, tutso@mit.edu

   > It's purposefully not on Ted's critical list, the official line is "use
   > pcmcia_cs external package" if you need i82365 or tcic instead of yenta

   Ted, is this true? It would be wonderfull to be able to use i82365 without
   need for pcmcia_cs...

   I think in-kernel pcmcia crashing even on simple things *is* critical bug.

It was Linus who said that Pcmcia crashing wasn't necessarily a critical
bug since 2.2 didn't have Pcmcia support in-kernel, and that for 2.4, it
was likely that most distributions would be best served to ship with
David Hind's external pcmcia driver.

That was several months ago, and perhaps things have changed.  But that
was I didn't spend time worrying about tracking PCMCIA bug reports;
there were a non-trivial number of them, and they were mostly of the
form "doesn't work on XXX hardware", "causes kernel oops on YYYY
hardware", etc.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
