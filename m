Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbTGPKr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271004AbTGPKr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:47:27 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:35720 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S271003AbTGPKrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:47:18 -0400
Date: Wed, 16 Jul 2003 07:02:06 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2 2.6.0-test1 issues
Message-ID: <20030716110206.GI2412@rdlg.net>
Mail-Followup-To: "Barry K. Nathan" <barryn@pobox.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716103851.GH2412@rdlg.net> <20030716105236.GD25869@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <20030716105236.GD25869@ip68-4-255-84.oc.oc.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



GAH, I should have know that one and yes it fixed both problems as well
as a new one with ETerms failing to start in X.

Thanks alot,
  Robert


Thus spake Barry K. Nathan (barryn@pobox.com):

> On Wed, Jul 16, 2003 at 06:38:51AM -0400, Robert L. Harris wrote:
> > I can SSH out of my 2.6.0-test1 box (IPv4 and IPv6).  When I try to ssh
> > in though I get a prompt for a passphrase like normal but once I enter
> > it nothing happens it just hangs there.
> >=20
> > On bootup I get multiple FATAL messages about tty and ttyS.  They're
> > scattered throughout the startup process and don't seem tied to any
> > particular init scripts.
>=20
> Make sure you have a line in /etc/fstab for /dev/pts, like the
> following:
>=20
> none /dev/pts devpts defaults 0 0
>=20
> My recollection is that I've seen this happen with at least some 2.4
> kernels as well, so it's not a 2.6-specific thing. I may not be
> remembering correctly, however.
>=20
> Also note that some distributions will go ahead and mount /dev/pts
> without having a line for it in /etc/fstab, so this isn't needed for all
> Linux boxes.
>=20
> -Barry K. Nathan <barryn@pobox.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FTCu8+1vMONE2jsRAuZ4AKC9H8wy+sCspCUl+evLJrVcGfXYFQCeOCEA
O3q9ny+FTJBYGti4gO+0yNI=
=bNr+
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
