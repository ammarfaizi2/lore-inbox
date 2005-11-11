Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVKKJKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKKJKA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVKKJKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:10:00 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:40143 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S932300AbVKKJJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:09:59 -0500
Date: Fri, 11 Nov 2005 09:09:32 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       davej@codemonkey.org.uk, blaisorblade@yahoo.it
Subject: Re: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051111090932.GA2345@inskipp.digriz.org.uk>
References: <20051110170040.GE16994@inskipp.digriz.org.uk> <200511111012.22163.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <200511111012.22163.kernel@kolivas.org>
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Con Kolivas <kernel@kolivas.org> [20051111 10:12:19 +1100]:
>
> On Fri, 11 Nov 2005 04:00, Alexander Clouter wrote:
> > The use of the 'ignore_nice' sysfs file is confusing to anyone using it.
> > This removes the sysfs file 'ignore_nice' and in its place creates a
> > 'ignore_nice_load' entry which defaults to '0'; meaning nice'd processes
> > *are* counted towards the 'business' caclulation.
>=20
> My 'nice'd compiles thank you from the bottom of their little cc1 hearts =
for=20
> changing your mind.
>=20
Well I succumbed as there are going to be some rather annoyed amd64 users o=
ut=20
there wondering why all their nice'd processes are taking forever to=20
compile...however it would be kinda of amusing; from my SparcClassic LX=20
perspective :)

Cheers

Alex

> Cheers,
> Con

--=20
 _______________________________________
/ An aphorism is never exactly true; it \
| is either a half-truth or             |
| one-and-a-half truths.                |
|                                       |
\ -- Karl Kraus                         /
 ---------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdF/MNv5Ugh/sRBYRAtkmAJ0Q9mbIVo47AzkdzfrTk7aV4vbCoACfeqej
hXXwL+FGWloCYYhKtXO8O+Q=
=Q4QX
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
