Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSCYB1R>; Sun, 24 Mar 2002 20:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312213AbSCYB1H>; Sun, 24 Mar 2002 20:27:07 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15877
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312212AbSCYB1C>; Sun, 24 Mar 2002 20:27:02 -0500
Date: Sun, 24 Mar 2002 17:26:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <3C9E581F.8030508@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203241522580.3759-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2002, Martin Dalecki wrote:

> Andre Hedrick wrote:
> 
> 
> > I have now several reports about Transmeta LifeBooks that are doing things
> > bad and not conforming to the docs.  This is not good.
> 
> Do they use the same design cells for ATA as ALI?
> That's interresting.

You got it!

Ones with profiles that should work in the current driver.
They are all C3 or C4 revisions function 1 and have a proper ISA mapping.
So unless this is a new SB core which has moved the enable hook or it is
an old one which has done the same ... well the mess is obvious.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


