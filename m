Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263197AbTDCAvC>; Wed, 2 Apr 2003 19:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263198AbTDCAvC>; Wed, 2 Apr 2003 19:51:02 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:14048
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S263197AbTDCAu6>; Wed, 2 Apr 2003 19:50:58 -0500
Date: Wed, 2 Apr 2003 17:02:17 -0800
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
Message-ID: <20030403010217.GA23813@triplehelix.org>
References: <20030327022732.GA2867@triplehelix.org> <Pine.LNX.4.44.0304022315150.3919-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304022315150.3919-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2003 at 11:16:12PM +0100, James Simmons wrote:
> > The junk quickly scrolls off into the sunset and has no adverse
> > effects on the following boot messages.
>=20
> I have a feeling take_over_console needs to run a vc_resize_console.

Actually, whatever was in the latest fbdev.diff.gz fixed it.
To be more precise, whichever fbdev.diff was in 2.5.65-mm1 and onwards.

The logo is still missing in action, I'm trying to debug this. Is anyone=20
noticing the same thing?

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+i4gZT2bz5yevw+4RAkyNAJ9e6UaF92beokn38+eVIf6MtJTo5QCfRz1S
uNwOVbWoRkOuxHjYxRLeSi0=
=VNsn
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
