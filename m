Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287229AbRL2XBi>; Sat, 29 Dec 2001 18:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287223AbRL2XB3>; Sat, 29 Dec 2001 18:01:29 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:29670
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287239AbRL2XBI>; Sat, 29 Dec 2001 18:01:08 -0500
Date: Sat, 29 Dec 2001 17:43:54 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011229174354.B8526@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Sat, Dec 29, 2001 at 02:24:55PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> > unless (ISA or PCI) suppress dependent IDE
> 
> Just a minor point, but what about non-PCI/ISA ide?

The CML1 rules seem to imply that this set is empty.

> > unless (X86 and PCI and EXPERIMENTAL) or PPC or ARM or SPARC suppress dependent IEEE1394
> 
> Wouldn't the experimental be global?  And maybe the PCI too?

I don't understand what change you are suggesting.

> > It seems to me *extremely* unlikely that a typical patch from a PPC
> > maintainer would mess with any of these!  They're rules that are likely to
> > be written once at the time a new port is added to the tree and seldom or
> > ever changed afterwards.
> 
> But they will be modified for new arch X, or when constraint X (like
> PCI) is removed.

Yes.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Experience should teach us to be most on our guard to protect liberty when the
government's purposes are beneficient...The greatest dangers to liberty lurk in
insidious encroachment by men of zeal, well meaning but without understanding."
	-- Supreme Court Justice Louis Brandeis
