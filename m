Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRIJQdh>; Mon, 10 Sep 2001 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRIJQd1>; Mon, 10 Sep 2001 12:33:27 -0400
Received: from c1608841-a.fallon1.nv.home.com ([65.5.95.44]:11416 "EHLO
	tarot.internal.aom.geek") by vger.kernel.org with ESMTP
	id <S271368AbRIJQdO>; Mon, 10 Sep 2001 12:33:14 -0400
Date: Mon, 10 Sep 2001 09:33:26 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: New SCSI subsystem in 2.4, and scsi idle patch
Message-ID: <20010910093326.A30659@ferret.dyndns.org>
In-Reply-To: <Pine.LNX.4.21.0109101216030.14338-100000@frank.gwc.org.uk> <Pine.LNX.4.10.10109101007150.15736-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10109101007150.15736-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.20i
From: idalton@ferret.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2001 at 10:10:11AM -0400, Mark Hahn wrote:
> > > I'm trying to get my 2.4.9 system to spin down my scsi disk(s) when i=
dle. =20
>=20
> remember: normal desktop drives have an expected life of only O(50k)=20
> spin up/down cycles.  that's twice an hour for a three year warranty...
>=20
> regards, mark hahn.

Noflushd can be useful in this case, though it needs a patch to
include/linux/kernel_stat.h in order to work with more than one
IDE disk. More information is at <http://noflushd.sourceforge.net>

Granted, heavy-use servers probably do not want to spin down so much,
though light-use servers could, with an high idle timeout.

--=20
Ferret

I will be switching my email addresses from @ferret.dyndns.org to
@mail.aom.geek on or after September 1, 2001, but not until after
Debian's servers include support. 'geek' is an OpenNIC TLD. See
http://www.opennic.unrated.net for details about adding OpenNIC
support to your computer, or ask your provider to add support to
their name servers.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7nOtVe0DNEkH06HMRAjCbAJ9yk7dMqTGLPNsgayLP8my2H6TCawCghUWm
/syE9caglRW+HeuXpoZKheQ=
=WIyI
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
