Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135307AbQK0CNA>; Sun, 26 Nov 2000 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135308AbQK0CMk>; Sun, 26 Nov 2000 21:12:40 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:55056 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S135307AbQK0CMg>; Sun, 26 Nov 2000 21:12:36 -0500
Date: Sun, 26 Nov 2000 19:39:28 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mohammad A. Haque" <mhaque@haque.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126193928.A2265@vger.timpanogas.org>
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org> <3A21968B.5CDB12BF@haque.net> <20001126170334.B1787@vger.timpanogas.org> <20001126161502.E872@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001126161502.E872@opus.bloom.county>; from trini@kernel.crashing.org on Sun, Nov 26, 2000 at 04:15:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 04:15:02PM -0700, Tom Rini wrote:
> On Sun, Nov 26, 2000 at 05:03:34PM -0700, Jeff V. Merkey wrote:
> 
> > Great.  Then tell RedHat to rewrite it without the need for these switches.
> > They will say NO.  It's a trivial change, and would save me a lot of hours
> > rewriting scripts.  I did it once, but if RedHat has standardized on this
> > set of switches, why not add them as alias commands?  It's a trivial 
> > patch.
> 
> I hate to jump in here in the middle of a perfectly good argument but I'd like
> to point out a few things:
> a) If RedHat/RedHat-like distros needs these changes they can include this
> patch.  The plus side is it won't piss off the people that seem to care and
> don't use said distros the down side is that if/when another security update
> comes out people will have to hope this patch applies easily still, if they
> update themselves.
> b) Are these switches which used to be valid in modutils 2.3.x?  If so, why?
> It makes perfect sense to keep this patch around until modutils 2.4 (or 2.5
> if modutils version is still supposed to match kernel version).  If these
> are old modutils 2.2.x switches, see part a).
> And c) Why does it matter if RedHat/etc would have to adapt their scripts.
> There's always part a, or what debian does for stable sometimes, backporting
> fixes.  Or even lots of sed & awk magic.

Oh well.  Look like %patch -p1 in the rpm for now.

Jeff

> 
> -- 
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
