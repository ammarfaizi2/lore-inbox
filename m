Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWEYV3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWEYV3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWEYV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:29:44 -0400
Received: from lug-owl.de ([195.71.106.12]:33981 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030424AbWEYV3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:29:44 -0400
Date: Thu, 25 May 2006 23:29:42 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: devmazumdar <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525212942.GS13513@lug-owl.de>
Mail-Followup-To: devmazumdar <dev@opensound.com>,
	linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8+OS07CeIgZ706fH"
Content-Disposition: inline
In-Reply-To: <e55715+usls@eGroups.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8+OS07CeIgZ706fH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 21:19:33 -0000, devmazumdar <dev@opensound.com> wrote:
> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.

You don't.  That's the user's task!

> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> SuSE, Mandrake and CentOS - how about other RPM based distros? How
> about debian based distros?. There doesn't seem to be a a single
> conherent naming scheme.=20

Indeed, there isn't.  Think about selfmade installations. Just ask the
user to provide you with the correct path. There may even be several
kernel version's source trees installed, with different configuration.

> Another thing, can we please start enforcing that people ship kernel
> source with the base installation? If distributors are distributing

No way.

> kernels, then it must be an absolute requirement that they ship kernel
> sources in a "configured" state as well.  If you're not going to
> provide a stable kernel API, then atleast please make this a requirement.=
=20

Distros *will* ship kernel's configuration, but that'll never ever be
installed by default.

If you work on drivers (as it seems), please just clean up the code
and post it to the kernel mailing list (or subsystem specific lists.)
Once it meets the standards, it'll just become a part of the tree,
releasing you from the burden to think about its local installation.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--8+OS07CeIgZ706fH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEdiHGHb1edYOZ4bsRAofBAJ9pDhXBLwqUhaCuwxdReTjAbFHBrACgjg6M
5gh2ApYlJeTg2k/wWuOK49Q=
=QEov
-----END PGP SIGNATURE-----

--8+OS07CeIgZ706fH--
