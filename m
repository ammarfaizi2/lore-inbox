Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293285AbSBXGC5>; Sun, 24 Feb 2002 01:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293289AbSBXGCs>; Sun, 24 Feb 2002 01:02:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8710 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293285AbSBXGCg>; Sun, 24 Feb 2002 01:02:36 -0500
Date: Sat, 23 Feb 2002 22:01:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Feb 2002, Andre Hedrick wrote:
>
> Lets both grow up!

I repeat, as I did in a private to-you-only email before: every _single_
complain you have had about the patches I've seen has been 100% bogus.

The patch was called "IDE cleanup", and cleanup it was. Nothing but. The
timings didn't change, although the stupid (twice duplicated) functions
that "calculated" them were removed and replaces with one boot-time
calculation.

Martin not only had "cleanup" in the subject line, but actually explained
all the changes, including the timing change. The comments at the top of
the patch mail said (on that particular change, which seems to have been
your favourite target), typos and all:

	3. Replace the functionally totally equal system_bus_block() and
	    ide_system_bus_speed() functions with one simple global
	    variable: system_bus_speed. This saves quite a significatn amount of
	    code. Unfortunately this is the part, which is makeing this
	    patch to appear bigger then it really is...

and the patch itself certainly agrees with what Martin claimed.

Your ranting, both on linux-kernel and on the IRC channels, has been
totally bogus, as if you didn't read either the explanation _or_ the
actual patch itself. And pointing this out multiple times doesn't seem to
have made any difference.

		Linus

