Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136072AbRAMBZT>; Fri, 12 Jan 2001 20:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136089AbRAMBZJ>; Fri, 12 Jan 2001 20:25:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:54026
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136072AbRAMBYw>; Fri, 12 Jan 2001 20:24:52 -0500
Date: Fri, 12 Jan 2001 17:24:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121717150.851-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101121719480.2411-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Fri, 12 Jan 2001, Andre Hedrick wrote:
> > 
> > I told you that I have the new code that is scheduled for 2.5 certified on
> > analizers to be technically correct as it relates to the "state diagrams"
> > in the standard.
> 
> "Technically correct" and "state diagrams as in the standard" mean less
> that nothing to me.
> 
> They have very little to do with the concept of "working", which is all I
> really personally care about.

Translation:

You can do a bit level tracking of data and verify that what went down you
get it back across the entire disk.  This can be done in a random-pattern
that does not over-write (obvious) or from head->tail or tail->head.

It works perfectly and exactly as it is defined to work by the rules.
Getting the rules correct == 'the concept of "working"'.

However that model of IO is not complete yet. :-((

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
