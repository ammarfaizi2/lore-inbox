Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLDPIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 10:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTLDPIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 10:08:53 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:60123 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262291AbTLDPIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 10:08:51 -0500
Date: Thu, 4 Dec 2003 16:08:46 +0100
From: Martin Waitz <tali@admingilde.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031204150846.GJ1117@admingilde.org>
Mail-Followup-To: J?rn Engel <joern@wohnheim.fh-wedel.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline
In-Reply-To: <20031203225743.A25889@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Wed, Dec 03, 2003 at 10:57:43PM +0000, Russell King wrote:
> Yes, but the condition of the /data/ is such that it will not recurse.
>=20
> A pure "can this function call that function" analysis ignoring the
> state of the data will say this will infinitely recuse.  Include
> the data, and you'll find it has a very definite recursion limit.

but it makes sense to restrucure the code to make it more
readable/understandable even if it can be proven that the code is
correct


--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/z039j/Eaxd/oD7IRAqVYAJ4hTpXWDARU8W0vKLq0y6duvp0siwCfS/pN
I+RRSobqujiLFdJ+qKizVh8=
=FjqZ
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
