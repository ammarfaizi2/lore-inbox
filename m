Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTBINRk>; Sun, 9 Feb 2003 08:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbTBINRk>; Sun, 9 Feb 2003 08:17:40 -0500
Received: from coruscant.franken.de ([193.174.159.226]:33961 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S267247AbTBINRj>; Sun, 9 Feb 2003 08:17:39 -0500
Date: Sun, 9 Feb 2003 11:00:17 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Netfilter-devel <netfilter-devel@lists.netfilter.org>,
       sclark46@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NAT counting]
Message-ID: <20030209100017.GV13269@naboo.fugue.com>
References: <1044545755.21354.9.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96icqjDFsSi85SgI"
Content-Disposition: inline
In-Reply-To: <1044545755.21354.9.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.20-nfpom1101
X-Date: Today is Prickle-Prickle, the 39th day of Chaos in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96icqjDFsSi85SgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2003 at 09:46:44PM -0500, Stephen Clark wrote:
>=20
> Is Linux being fixed to prevent this?

Linux is not 'being fixed', because I don't regard this as a bug - and
only bugs need fixing.

I don't want to have the NAT code to _always_ rewrite the IP ID because
of performance reasons.  I think we should leave the current behaviour
and provide an _optional_ 'IPID' target for the mangle table.  So
everybody who wants IP ID rewriting can use that target.

--=20
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--96icqjDFsSi85SgI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+RiaxXaXGVTD0i/8RAvugAKCkRlWQwm3uBVtc1KHU3aoeapPo7gCdFsxl
fzOKzVMP50wonseyYUNUyFg=
=TTJN
-----END PGP SIGNATURE-----

--96icqjDFsSi85SgI--
