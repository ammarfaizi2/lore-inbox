Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288750AbSADUKW>; Fri, 4 Jan 2002 15:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbSADUKD>; Fri, 4 Jan 2002 15:10:03 -0500
Received: from ns.suse.de ([213.95.15.193]:30479 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288735AbSADUJ7>;
	Fri, 4 Jan 2002 15:09:59 -0500
Date: Fri, 4 Jan 2002 21:09:54 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104144146.A20097@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201042101400.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> X86 and ((not PCI) or (not DMI) or DMI_ISA or BLACKLISTED => ISA_CARDS

You'd also need (not MCA) (not VLBUS) (not Other arcane non-ISA buses)

> A key point is that as ISA phases out (near future now), the blacklist
> will stop growing.  Ballpark guess is it will top out below 150 entries.

I showed you 4 examples of bad DMI tables found within 5 minutes of
testing here. I'm one person. There's a lot of hardware out there,
with a lot of broken BIOSes. (Yes, you have different bugs per BIOS,
with sometimes a dozen or so revisions just for 1 board).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

