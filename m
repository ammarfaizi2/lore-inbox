Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRH1QJo>; Tue, 28 Aug 2001 12:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271799AbRH1QJY>; Tue, 28 Aug 2001 12:09:24 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:21162 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S271798AbRH1QJF>; Tue, 28 Aug 2001 12:09:05 -0400
Date: Tue, 28 Aug 2001 11:08:46 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828110846.T16752@draal.physics.wisc.edu>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu> <20010828083537.B7376@kroah.com> <20010828105330.S16752@draal.physics.wisc.edu> <20010828090126.A7544@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nKvJs6ze6az+4fwY"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010828090126.A7544@kroah.com>; from greg@kroah.com on Tue, Aug 28, 2001 at 09:01:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nKvJs6ze6az+4fwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg KH [greg@kroah.com] wrote:
> On Tue, Aug 28, 2001 at 10:53:30AM -0500, Bob McElrath wrote:
> >=20
> > The behaviour of the usb-storage stuff is unchanged from 2.4.7, but the
> > visor definitely did work with 2.4.7, where it doesn't now.
>=20
> But the usb-storage code did change from 2.4.7-2.4.9 while the visor
> code hasn't :)
>=20
> So I'd try unloading the usb system (or rebooting if it's compiled into
> the kernel), and just trying a visor sync without running the
> usb-storage code to try to narrow down the potential problem.

I tried the visor first, and saw this behavior.  (without even insmoding
the usb-storage driver)  I tried it several times, with the same
results.  Only this morning before sending my message did I try the
usb-storage to see if it was broken too.

I've rmmod'ed everything and re-insmoded everything (except usb-storage)
with the same results.

Maybe related:
Why would /proc/bus/usb be always empty?

I'll reboot to 2.4.7 again when I get home tonight and try it.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--nKvJs6ze6az+4fwY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuLwg4ACgkQjwioWRGe9K39RQCg6olC2knBhrQbZhmIc7f1q5VY
gmoAn1W/tC2sS9NOHLvKgEa/oS24omOc
=R2zQ
-----END PGP SIGNATURE-----

--nKvJs6ze6az+4fwY--
