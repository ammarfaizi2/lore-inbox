Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUIMTK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUIMTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUIMTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:10:28 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:18638 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S268861AbUIMTKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:10:20 -0400
Date: Mon, 13 Sep 2004 21:07:41 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Willy Tarreau <willy@w.ods.org>
Cc: Paul Jakma <paul@clubi.ie>, Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040913190741.GD19399@thundrix.ch>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain> <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org> <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org> <20040913041846.GD2780@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20040913041846.GD2780@alpha.home.local>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Mon, Sep 13, 2004 at 06:18:47AM +0200, Willy Tarreau wrote:
> > The BGP state machine should instead, in normal operation, have=20
> > only treated Hold time expired as the definitive sign of "peer is=20
> > down" and allowed reconnects.
>=20
> It should not necessarily wait for the time-out, but at least wait for
> a few reconnect errors.

Problem  there: you  can fake  connection errors  almost as  easily as
sending an RST packet, so the DoS might reappear, might it not?

				Tonnerre

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD4DBQFBRe/8/4bL7ovhw40RAns4AKCEHPFN5dKLrmwgdJuE+UK2w5pdNQCXdE7t
Ipp+iizNsDSClV0ExUFb+w==
=RsZd
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
