Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSADUbc>; Fri, 4 Jan 2002 15:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbSADUbW>; Fri, 4 Jan 2002 15:31:22 -0500
Received: from ns.suse.de ([213.95.15.193]:38161 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288747AbSADUbQ>;
	Fri, 4 Jan 2002 15:31:16 -0500
Date: Fri, 4 Jan 2002 21:31:14 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.GSO.3.96.1020104211143.829K-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0201042128360.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Maciej W. Rozycki wrote:

>  That seems impossible in the real world.  I don't think it's possible to
> detect physical connectors on a PCB for any bus -- I've even seen boards
> with soldering spots for bus connectors but no connectors themselves.

I agree. The best you can do is make educated guesses...

> Relying on reporting anything optional being done right by a BIOS is an
> illusion -- even mandatory things are screwed in many PC BIOSes.

Indeed. Something I'm trying to convey to Eric, but I don't think
he realises just how many pooched BIOSen there are out there.
His conservative estimate of '150 entries in the blacklist'
is possibly off by an order of 10 times or more.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

