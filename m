Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285585AbRLWI0b>; Sun, 23 Dec 2001 03:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285590AbRLWI0V>; Sun, 23 Dec 2001 03:26:21 -0500
Received: from CPE0002b3140673.cpe.net.cable.rogers.com ([24.156.0.228]:31948
	"EHLO pyre.virge.net") by vger.kernel.org with ESMTP
	id <S285585AbRLWI0L>; Sun, 23 Dec 2001 03:26:11 -0500
Date: Sun, 23 Dec 2001 03:26:09 -0500
From: Norbert Veber <nveber@pyre.virge.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference to `local symbols...
Message-ID: <20011223082609.GA10136@pyre.virge.net>
In-Reply-To: <20011223032213.GA20031@pyre.virge.net> <22315.1009084719@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <22315.1009084719@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2001 at 04:18:39PM +1100, Keith Owens wrote:
> Got bored, wrote some Perl (Oh hang on, I've used that before).
>=20
> net/network.o is not much help, it is a conglomerate object.  I need
> the individual object that is failing.  cd linux and run
> reference_discarded.pl below.

nveber@pyre[9526:/usr/src/linux]$ ~/reference_discarded.pl
Finding objects, 790 objects, ignoring 132 module(s)
Finding conglomerates, ignoring 57 conglomerate(s)
Scanning objects
Error: ./net/ipv4/netfilter/ip_nat_snmp_basic.o .text.lock refers to 000000=
3c R_386_PC32        .text.exit
Done

>=20
> Any other patches applied?

Nope.

Thanks,

Norbert

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8JZUhohfEw14utbQRAi7ZAJ4xrBoVi0CYQcxza+VY7DfcRt5NuACgtvpp
Jf2GDyTO6i9TXX9Z3dgcZqU=
=Ihwl
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
