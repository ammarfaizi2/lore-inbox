Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVBPTzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVBPTzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVBPTzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:55:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:35546 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261541AbVBPTyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:54:12 -0500
Date: Wed, 16 Feb 2005 14:54:01 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Reinhard Tartler <siretart@stud.uni-erlangen.de>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050216195400.GA31729@butterfly.hjsoft.com>
References: <20050210124636.GA10677@butterfly.hjsoft.com> <slrnd16sk6.4g9.siretart@faui06.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <slrnd16sk6.4g9.siretart@faui06.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2005 at 04:16:38PM +0000, Reinhard Tartler wrote:
> > I can suspend my R40 with swsusp, then boot it and resume fine=20
> > most of
> > the time.
> > I'd say nearly 50$ of the time though, the machine will freeze=20
> > within 5
> > minutes of resuming.
> > SysRq doesn't work, no oops when in console mode, no network, no=20
> > disk
> > activity, just frozen.  Occassionally, I've seen a line or 2 of
> > pixels on my X screen get corrupted.
> Do you happen to use the madwifi drivers? If you are you might be
> affected by bad interaction from madwifi with laptop mode patches.=20
> This
> has been reported to ubuntu in
> https://bugzilla.ubuntu.com/show_bug.cgi?id=3D6108
>=20
> Unfortunatly, the only known fix up to now is to disable either=20
> madwifi
> oder laptop-mode. :(

I use the ipw2100.sf.net drivers, and I've gotten the freeze without
even having those modules loaded, so I doubt that's it.

I'm currently testing booting with acpi=3Doff.  While, I've not had a
freeze yet (nearly 2 days), I may take your advice and test with
laptop-mode disabled as well, since I could definitely tolerate the loss
of laptop-mode better than the loss of my ACPI events and info.
--=20
John M Flinchbaugh
john@hjsoft.com

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCE6TYCGPRljI8080RAo8UAJ41HUwOokg/wtMMABrLkPZFLGPovQCaAkKR
o9nP0aAvnb0AoUeIGP323R4=
=FiJ2
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
