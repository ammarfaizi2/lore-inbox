Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWBULqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWBULqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWBULqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:46:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:27569 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932702AbWBULqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:46:30 -0500
X-Authenticated: #428038
Date: Tue, 21 Feb 2006 12:46:25 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: [OT] portable Makefiles (was: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060221114625.GA29439@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Joerg Schilling <schilling@fokus.fraunhofer.de>
References: <43EB7BBA.nailIFG412CGY@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner> <20060221101644.GA19643@merlin.emma.line.org> <43FAF2FA.nailD12BW90DH@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAF2FA.nailD12BW90DH@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-21:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Joerg Schilling schrieb am 2006-02-21:
> >
> > > Try to use my smake to find out whether you use non-portable constructs.
> > > Smake warns you about the most common problems in makefiles.
> >
> > To complement this, running Solaris' /usr/{ccs,xpg4}/bin/make and BSD's
> > portable make (just bootstrap www.pkgsrc.org to obtain "bmake" on Linux)
> > is probably a much better approach since it tests real-world make
> > implementations rather than an artificial and not widely available local
> > flavor.
> 
> Thank you for proving that you are completely uninformed!

You just proved your incapability to extract the meaning of five simple
lines. If you're incapable to understand simple statements like these,
shut your head.

The meaning is, just especially for you so you can excuse yourself, and
in PowerPoint style to be easy on your time:

- run Solaris' /usr/{ccs,xpg4}/bin/make
  to find out if your Makefile is portable

- run BSD's portable make (that's a proper name)
  to find out if your Makefile is portable

- testing real-world make programs with Makefiles will find out much
  more reliably if non-portable constructs are used.

Examples: smake -W -posix (version 1.2a34, the newest available) doesn't
warn of include foo.d (works with said make tools, but isn't POSIX
compliant), and doesn't warn of -include foo.d (works with smake, GNU
make, BSD make, but not SUN make).

This is pretty strong evidence that smake is insufficient as
Makefile portability validator, which substantiates my recommendation to
test real-world make(1) programs rather than smake to find out the
portability characteristics.

And now repeat your insult I were uninformed again,
that's your quickest way to criminal prosecution.
You said good-bye to factual discussion long ago.

-- 
Matthias Andree
