Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUEWPgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUEWPgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUEWPgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:36:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263062AbUEWPfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:35:22 -0400
Date: Sun, 23 May 2004 17:35:10 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040523153510.GA24628@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <1085299337.2781.5.camel@laptop.fenrus.com> <20040523152540.GA5518@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20040523152540.GA5518@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 23, 2004 at 08:25:40AM -0700, Greg KH wrote:
> On Sun, May 23, 2004 at 10:02:17AM +0200, Arjan van de Ven wrote:
> > On Sun, 2004-05-23 at 08:46, Linus Torvalds wrote:
> > > Hola!
> > > 
> > > This is a request for discussion..
> > 
> > Can we make this somewhat less cumbersome even by say, allowing
> > developers to file a gpg key and sign a certificate saying "all patches
> > that I sign with that key are hereby under this regime". I know you hate
> > it but the FSF copyright assignment stuff at least has such "do it once
> > for forever" mechanism making the pain optionally only once.
> 
> I don't think that adding a single line to ever patch description is
> really "pain".  Especially compared to the FSF proceedure :)
> 
> Also, gpg signed patches are a pain to handle on the maintainer's side
> of things, speaking from personal experience.  However our patch
> handling scripts could probably just be modified to fix this issue, but
> no one's stepped up to do it.

I'll buy that

>  And we'd have to start messing with the
> whole "web of trust" thing, which would keep us from being able to
> accept a patch from someone in a remote location with no way of being
> able to add their key to that web, causing _more_ work to be done to get
> a patch into the tree than Linus's proposal entails.

But I don't buy this. No web of trust is needed if all that is happening is
filing a form ONCE saying "all patch submissions signed with THIS key are
automatically certified". That doesn't prevent non-gpg users from using the
proposed mechanism nor involves web of trust metrics.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQFAsMSuxULwo51rQBIRAp0dAJsEXM+6g0Gq4Lg6hapUGrrQiJ5E9QCYs7DQ
KUPFbI0PsSpDqdSVVKo/OQ==
=C/Bx
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
