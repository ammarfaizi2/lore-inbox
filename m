Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286710AbRLVIGF>; Sat, 22 Dec 2001 03:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286711AbRLVIFm>; Sat, 22 Dec 2001 03:05:42 -0500
Received: from femail39.sdc1.sfba.home.com ([24.254.60.33]:11169 "EHLO
	femail39.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S286710AbRLVIFl>; Sat, 22 Dec 2001 03:05:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: esr@thyrsus.com, Reid Hekman <reid.hekman@ndsu.nodak.edu>
Subject: Re: Configure.help editorial policy
Date: Fri, 21 Dec 2001 19:04:06 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011220143247.A19377@thyrsus.com> <1008880024.3926.2.camel@localhost.localdomain> <20011220152340.A20824@thyrsus.com>
In-Reply-To: <20011220152340.A20824@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011222080538.EPWH4664.femail39.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 03:23 pm, Eric S. Raymond wrote:
> Reid Hekman <reid.hekman@ndsu.nodak.edu>:
> > Perhaps if we could be so bold as to back Donald Knuth's KKB,MMB,GGB
> > proposal (of which I learned here:
> > http://www.linuxdoc.org/HOWTO/Large-Disk-HOWTO-3.html ).
>
> Hm.  Attractive, but it doesn't have an ISO standard behind it.

Two words: "Posix threading."

Somebody had to say it.

How many successful real-world networks have been designed around the OSI 7 
layer burrito networking model?

ISO standards do not define reality much on the internet.  RFCs define 
reality quite often on the internet.  Most RFCs come well after the fact, and 
an amazing number of RFCs are ignored or quickly replaced.  Several of them 
ADMIT to being jokes.  Are you saying an ISO pronouncement has MORE weight 
than an RFC?

ISO got into the computing world largely by rubber-stamping existing 
standards from ANSI, CCITT, IEEE, and elsewhere.  Not by making good 
decisions.  The ISO will happily standardize sugar cube sizes and pencil lead 
density.  They don't HAVE to know anything about the subject in question.

The best standards are the ones that either document practices that already 
exist or define a draft interoperability procol hammered out by the parties 
who are going to implement it (preferably with sample code which ends up 
being worth more than the standards document).

Do you expect Microsoft to start using the term "mebibyte" any time soon?  Or 
hard drive manufacturers (who largely use decimal megabytes anyway for 
marketing reasons)?  Or ram manufacturers who obviously want end users to 
learn a new term to buy their products?  It would be a stupid marketing move. 
 (Sheesh, AMD's launching a major campaign to get away from "megahertz".  And 
failing at it, I might add.)  How long did it take for end users to stop 
referring to the "baud rate" of their modem, which hasn't been technically 
true since the 300 baud days.  (A "2400 baud" modem was actually 600 baud, 4 
symbol if I remember correctly...)

In the short term, this change to the help files (which people look at when 
they DON'T know stuff) is GUARANTEED to confuse WAY more people than it even 
hopes to help over at least the next two years.  Almost everybody who sees it 
is going to have to ask "what's a mebibyte" and go look it up.  Does this 
really make the help file more helpful?

If the term goes into widespread use, THEN switch.  If you want to make a 
policy about it, we currently use binary measures when we measure memory or 
storage in the linux kernel unless otherwise specified.  Always have done.

Rob
