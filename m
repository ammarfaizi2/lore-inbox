Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288675AbSADTpd>; Fri, 4 Jan 2002 14:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288728AbSADTpW>; Fri, 4 Jan 2002 14:45:22 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:18185 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288675AbSADTpK>; Fri, 4 Jan 2002 14:45:10 -0500
Date: Fri, 4 Jan 2002 20:45:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104204508.C22591@suse.cz>
In-Reply-To: <20020104200410.E21887@suse.cz> <Pine.GSO.3.96.1020104202932.829H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020104202932.829H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 04, 2002 at 08:36:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 08:36:06PM +0100, Maciej W. Rozycki wrote:
> On Fri, 4 Jan 2002, Vojtech Pavlik wrote:
> 
> > And of course, there will be a huge amount of false positives, because
> > all the new chipsets have an ISA bridge built into the southbridge chip
> > and it is there even when no ISA slots are present.
> 
>  A false positive is less painful than a false negative.  Then if a system
> has a PCI-ISA bridge, it's surely for purpose there (otherwise what is the
> justification for the additional cost of unused silicon?).  Maybe for an
> on-board ISA serial or parallel port or an ISA floppy controller...

Because it's much cheaper to buy an off-the-shelf southbridge, even if
you're not going to use the ISA bus for any devices if you're making an
ISA-less mainboard, than trying to find or even design one without an
ISA bridge in it.

I recall people using the vt82c686a's with StrongARM CPUs even ...

-- 
Vojtech Pavlik
SuSE Labs
