Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270237AbRHGXrp>; Tue, 7 Aug 2001 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGXrg>; Tue, 7 Aug 2001 19:47:36 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:1548
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S270233AbRHGXra>; Tue, 7 Aug 2001 19:47:30 -0400
Date: Tue, 7 Aug 2001 16:47:40 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: =?iso-8859-1?Q?=D8ystein_Haare?= <oyhaare@online.no>,
        linux-kernel@vger.kernel.org
Subject: Re: Via chipset
Message-ID: <20010807164740.U23718@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?=D8ystein_Haare?= <oyhaare@online.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <997225828.10528.4.camel@eagle> <E15UGOw-0004H2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15UGOw-0004H2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 08, 2001 at 12:36:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reoccurring question on this (and many other) list[s].  It seems
like someone ought to maintain a database of boards that are known to work
and what they are used for.  For example,  lots of people say "such and such
works for me" but what they don't say is "I only have 1 disk and 1 CDROM and
nothing else".

I've had fairly good luck with just about any board as long as I don't 
beat on the IDE on a VIA chipset board.  I switched all my servers over
to 3ware Escalades to get off the IDE; that helped tremendously but it
adds about $400 to a system (3ware card and you will probably want a 
better PS and cooling, so maybe more).

Yeah, I know, if I'm whining I should volunteer the space.  OK, I'll do the
following: if someone starts gathering the data in a simple way (see below)
then I'll archive it all in a database and make it accessible via the web.
If you are interested in doing this, which means you write the script that
gathers the info, contact me offline and we'll set it up.

The data format I want is simple.  Imagine a perl script gathering the
info into an associative array, the key is the field name like "cpu" or
"motherboard" etc., and the value is the value, like "AMD K7" or "ASUS A7V".
It would be good to have a set of required fields so people can query 
across those fields, but there need not be any limit on how many fields and
all fields need not be present in all records.  

Once you have that, I can send you some code that will shlep over that data
to me and I have tools here that will eat it and store it into a database.
Our bugdatabase is lot like this, it's a fairly trivial change to support
this as a sort of bugdatabase like thing.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
