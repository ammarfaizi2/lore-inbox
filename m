Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSCYJmT>; Mon, 25 Mar 2002 04:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312376AbSCYJl7>; Mon, 25 Mar 2002 04:41:59 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44549
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312375AbSCYJl5>; Mon, 25 Mar 2002 04:41:57 -0500
Date: Mon, 25 Mar 2002 01:40:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <20020325102432.B13083@ucw.cz>
Message-ID: <Pine.LNX.4.10.10203250139430.6920-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The issue is already being handled.
The OEM will collect the hardware and derive a new driver for opensource.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 25 Mar 2002, Vojtech Pavlik wrote:

> On Sun, Mar 24, 2002 at 05:26:23PM -0800, Andre Hedrick wrote:
> > On Sun, 24 Mar 2002, Martin Dalecki wrote:
> > 
> > > Andre Hedrick wrote:
> > > 
> > > 
> > > > I have now several reports about Transmeta LifeBooks that are doing things
> > > > bad and not conforming to the docs.  This is not good.
> > > 
> > > Do they use the same design cells for ATA as ALI?
> > > That's interresting.
> > 
> > You got it!
> > 
> > Ones with profiles that should work in the current driver.
> > They are all C3 or C4 revisions function 1 and have a proper ISA mapping.
> > So unless this is a new SB core which has moved the enable hook or it is
> > an old one which has done the same ... well the mess is obvious.
> 
> >From the lspci's I've seen, this looks like the LifeBooks, although
> using the Crusoe chip with integrated northbridge, are using a standard
> ALI southbridge - not a design of their own with licensed cells.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

