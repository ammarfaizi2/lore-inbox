Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318907AbSG1Eor>; Sun, 28 Jul 2002 00:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318908AbSG1Eor>; Sun, 28 Jul 2002 00:44:47 -0400
Received: from bitmover.com ([192.132.92.2]:57235 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318907AbSG1Eoq>;
	Sun, 28 Jul 2002 00:44:46 -0400
Date: Sat, 27 Jul 2002 21:47:58 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
Message-ID: <20020727214758.A28328@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, Daniel Egger <degger@fhm.edu>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <Pine.LNX.4.44.0207271939220.3799-100000@home.transmeta.com> <Pine.LNX.4.44.0207272131250.6125-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207272131250.6125-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Jul 27, 2002 at 09:40:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 09:40:40PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 27 Jul 2002, Linus Torvalds wrote:
> >
> > I'm talking about people who don't even bother to do
> > bug-reports, but only trash-talk the maintenance.
> 
> On that note, let me mention the machines I personally am using IDE, and
> apparently do not see problems: a dual PII with "Intel Corp. 82371AB PIIX4
> IDE", and a P4 with "SiS 5513 IDE (rev 208)".
> 
> Both setups in DMA mode, both setups have one disk per channel (first
> channel is disk, second channel is CD-ROM).
> 
> So what are the patterns for "working" vs "broken"?

In the probably-not-useful department because I haven't tested on 2.5, 
my experience over a quite some time has been that you find a lot more
problems when you are actively beating on both channels.  There is some
chipset, I suspect you know which but Andre certainly does, that is just
basically busted when you use both channels.  I've had so many problems
with this that for any data I care about I plug in a 3ware controller
and use that instead.

I have a diskscrubber program which runs the bits through a series of
changes, it's pretty trivial to write but I can post mine if you like,
it works for banging on the disk.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
