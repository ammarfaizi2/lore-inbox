Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319545AbSIHAqi>; Sat, 7 Sep 2002 20:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319550AbSIHAqi>; Sat, 7 Sep 2002 20:46:38 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:656 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S319545AbSIHAqh>; Sat, 7 Sep 2002 20:46:37 -0400
Date: Sat, 7 Sep 2002 19:50:32 -0500
From: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
Message-ID: <20020908005032.GB4828@draal.physics.wisc.edu>
References: <20020907183328.GB5985@draal.physics.wisc.edu> <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andre Hedrick [andre@linux-ide.org] wrote:
> On Sat, 7 Sep 2002, Bob McElrath wrote:
>=20
> Would you pass hdc=3Dscsi for the next reboot?

As this is an IDE device I'm not sure what hdc=3Dscsi should do...

However that seems to get rid of the oops.  It appears to operate
normally (I can mount CD's, DVD's, play DVD's, and play CD's).
cdparanoia even works (with no sg module installed -- which I thought it
needed) though while it's running the CPU usage jumps to 100%.  :(

I see that the Configure.help now says to use "hdx=3Dscsi".  I am not sure
where I received the information to use "hdx=3Dide-scsi" but that did work
with kernel 2.4.18.

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj16ntgACgkQjwioWRGe9K1G7QCg+BT+eGe7CuLIaDU7em0lrYG2
qUMAnAzK+SUrlR1E3pD5Op70IwMmVNDi
=dCDX
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
