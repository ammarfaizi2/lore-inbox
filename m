Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTBEASR>; Tue, 4 Feb 2003 19:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbTBEASR>; Tue, 4 Feb 2003 19:18:17 -0500
Received: from bitmover.com ([192.132.92.2]:42889 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267629AbTBEASQ>;
	Tue, 4 Feb 2003 19:18:16 -0500
Date: Tue, 4 Feb 2003 16:27:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Eli Carter <eli.carter@inet.com>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030205002746.GA10206@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Eli Carter <eli.carter@inet.com>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com> <3E405207.8080207@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E405207.8080207@inet.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, dumb, (and probably flamebait) question time:  I read your list and 
> thought "In C? Why not Python?"  I'm guessing speed issues?

Scripting languages are unacceptable for products.  Flat out unacceptable.
I spoke to Chip when he was running the perl effort, his answer was "if
you are worried about new releases of perl breaking your scripts, ship
your own version of perl".  I spoke with Guido or some other Python 
luminary and he said the same thing.

For something which a company has to support, it needs to be a compiled 
language with fairly minimal dependencies.  Otherwise the customer 
upgrades and the tool breaks.

Don't get me wrong, I love perl (well, perl 4, perl 5 got a bit weird
for my tastes but some people seem to like it) and python looks cool as
well.  They are great for prototyping but they are just useless as a 
application platform.  Our support costs would be through the roof.

Before the inevitable flameage, please consider that we have to support
people who insist on using all sorts of weird things.  Richard Gooch
maintains his own a.out based linux distribution, for example.  Do we
get to tell him to upgrade?  Nope.  And it just gets worse from there.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
