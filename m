Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312379AbSCYJZl>; Mon, 25 Mar 2002 04:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312376AbSCYJZb>; Mon, 25 Mar 2002 04:25:31 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:59597 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312375AbSCYJZ1>;
	Mon, 25 Mar 2002 04:25:27 -0500
Date: Mon, 25 Mar 2002 10:24:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
Message-ID: <20020325102432.B13083@ucw.cz>
In-Reply-To: <3C9E581F.8030508@evision-ventures.com> <Pine.LNX.4.10.10203241522580.3759-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 05:26:23PM -0800, Andre Hedrick wrote:
> On Sun, 24 Mar 2002, Martin Dalecki wrote:
> 
> > Andre Hedrick wrote:
> > 
> > 
> > > I have now several reports about Transmeta LifeBooks that are doing things
> > > bad and not conforming to the docs.  This is not good.
> > 
> > Do they use the same design cells for ATA as ALI?
> > That's interresting.
> 
> You got it!
> 
> Ones with profiles that should work in the current driver.
> They are all C3 or C4 revisions function 1 and have a proper ISA mapping.
> So unless this is a new SB core which has moved the enable hook or it is
> an old one which has done the same ... well the mess is obvious.

>From the lspci's I've seen, this looks like the LifeBooks, although
using the Crusoe chip with integrated northbridge, are using a standard
ALI southbridge - not a design of their own with licensed cells.

-- 
Vojtech Pavlik
SuSE Labs
