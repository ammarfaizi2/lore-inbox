Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbTIHWcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTIHWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:32:52 -0400
Received: from [207.188.30.29] ([207.188.30.29]:31 "EHLO mpenc1.prognet.com")
	by vger.kernel.org with ESMTP id S263718AbTIHWbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:31:15 -0400
Date: Mon, 8 Sep 2003 15:30:57 -0700
From: Tom Marshall <tommy@home.tig-grr.com>
To: Daniel Ritz <daniel.ritz@gmx.ch>, Sven Dowideit <svenud@ozemail.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Problems with PCMCIA (Texas Instruments PCI1450)
Message-ID: <20030908223057.GA28154@home.tig-grr.com>
References: <200308270056.33190.daniel.ritz@gmx.ch> <200309052019.30051.daniel.ritz@gmx.ch> <20030905193811.C14076@flint.arm.linux.org.uk> <200309052140.27906.daniel.ritz@gmx.ch> <20030905205429.D14076@flint.arm.linux.org.uk> <20030906174140.C29417@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20030906174140.C29417@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Ok, now I need to hear from Sven (and others) to see if this patch fixes
> > their problems.  Also, are these other people running a SMP kernel as
> > well?
>=20
> Ok, I've updated pcmcia.arm.linux.org.uk with a couple of patches which
> should solve the real cause of problem - a nice race condition.  I'm
> including the patch here - can people which this problem check whether
> it solves the problem on their hardware?
>=20
> I'd like to hear back from people who have been affected by this bug
> before I push this patch to Linus.

Seems to work for me.  Thanks!  :-)

--=20
If voting could change the system, it would be illegal.  If not voting
could change the system, it would be illegal.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj9dAyEACgkQFMm9uvwPXW5DbACdF62sox9TTNge4zfxtQhr583O
41QAn3HEJBoFBYx+9jC3WSXb/Rvy21rx
=64ZY
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
