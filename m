Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129333AbRBGRe4>; Wed, 7 Feb 2001 12:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGReg>; Wed, 7 Feb 2001 12:34:36 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:52384 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S129333AbRBGReZ>;
	Wed, 7 Feb 2001 12:34:25 -0500
Date: Wed, 7 Feb 2001 18:24:44 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Manfred Spraul <manfred@colorfullife.com>
cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org
Subject: Re: APIC lockup in 2.4.x-x
In-Reply-To: <3A8031AA.1FFDF6AE@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0102071821460.6615-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Manfred Spraul wrote:

> Martin Josefsson wrote:
> > 
> > Hi
> > 
> > I saw your patch for the APIC lockup and I saw that it was included in
> > 2.4.1-ac2 so I tried that one.. but it didn't help..
> > 
> > I can begin with describing my machine:
> > 
> > dual pIII 800 (133MHz FSB)
> > Asus P3C-D mainboard with i820 chipset
> > 256MB rimm (rambus)
> > Dlink DFE570TX (4 port tulip card)
> > Adaptec 29160 scsicard and 18GB scsidisk.
> >
> 
> Could you apply the attached patch, enable sysrq, compile & install the
> kernel, reboot and press sysrq-q after ifup?
> 
> We assumed that only the old io apic for 440 BX boards is affected, but
> your board contains a newer apic intrated in the ICH.
> 
> But probably you ran into another bug - the tulip driver doesn't use
> disable_irq()

Hi

After running the test during night I saw that the machine had hung a few
minutes after I want to bed. It didn't respond to anything, not even sysrq

Any more ideas?
If you have any suggestions or any patch that might fix it or show where
the problem is, send it to me. I'll test all patches, this is a
testmachine right now.

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
