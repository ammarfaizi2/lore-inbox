Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135718AbRAMBtz>; Fri, 12 Jan 2001 20:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136215AbRAMBtp>; Fri, 12 Jan 2001 20:49:45 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:56842
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135718AbRAMBtb>; Fri, 12 Jan 2001 20:49:31 -0500
Date: Fri, 12 Jan 2001 17:48:51 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121726590.893-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101121736490.2411-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Fri, 12 Jan 2001, Andre Hedrick wrote:
> > 
> > It works perfectly and exactly as it is defined to work by the rules.
> > Getting the rules correct == 'the concept of "working"'.
> 
> Don't be silly.
> 
> You're entirely ignoring the concept of hardware bugs. Which is one very
> likely reason for this whole discussion in the first place.
> 
> ANYBODY who does driver development without taking the real world into
> account is a dangerous person. Stacks of papers, diagrams and rules are
> absolutely WORTHLESS if you can't just understand the fact that
> documentation is nothing more than a guide-line.
> 
> Once you realize that documentation should be laughed at, peed upon, put
> on fire, and just ridiculed in general, THEN, and only then, have you
> reached the level where you can safely read it and try to use it to
> actually implement a driver.
> 
> I'm continually amazed and absolutely scared silly by your blind trust in
> paperwork, whether it be standards or committees or vendor documentation.

Test and Verify!  It has been abused on an ATA-Analyzer!
It was written while running on an ATA-Analyzer!
The real world does not get any more real than on an ATA-Analyzer!
Since this was a done by direct access with out the FS/VM mess it is an
exact method of operation, it is a perfect data-signal trace.
Perfect == fits exactly in the boundaries of the state-diagrams.

This is how you write code, LT.

Follow the rules, and the verify the rules are correct.
If they are not, fix it until it is correct and see what happened in the
rules.  I have offered to get you signed letters of technical
certification by the drive makers, and you have declined.

The idea of just banging code to get the desired result regardless of
public methods published to insure comman design/correctness is all but
silly.  What do you think timing tables are for, wallpaper or to line the
bottom of a bird cage?  Sheesh....  You have to access a PCI-bus, CPU, AGP
and all these other things in the correct event windows, or do you?

Regards,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
