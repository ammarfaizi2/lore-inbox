Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264464AbRFTAmW>; Tue, 19 Jun 2001 20:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRFTAmC>; Tue, 19 Jun 2001 20:42:02 -0400
Received: from lorax.neutraldomain.org ([64.81.248.141]:17159 "HELO
	lorax.neutraldomain.org") by vger.kernel.org with SMTP
	id <S264458AbRFTAl7>; Tue, 19 Jun 2001 20:41:59 -0400
Date: Tue, 19 Jun 2001 17:42:27 -0700
From: Gabriel Rocha <grocha@onesecure.com>
To: Kelledin Tane <runesong@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619174227.K81548@onesecure.com>
Mail-Followup-To: Kelledin Tane <runesong@earthlink.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com> <20010619143253.F81548@onesecure.com> <3B2FED41.DD8E2B95@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="P7Tqkd/m/Jnohiaz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B2FED41.DD8E2B95@earthlink.net>; from runesong@earthlink.net on Tue, Jun 19, 2001 at 07:24:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--P7Tqkd/m/Jnohiaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

the 'compile in one place and export the product via nfs' mentality
really kicks in under *bsd, where you may have a server farm and want to
upgrade all at once...the tarball idea works for one machine, but for
multiples, its all about exporting it... just my 2 cents. --gabe


,----[ On Tue, Jun 19, at 07:24PM, Kelledin Tane wrote: ]--------------
| Gabriel Rocha wrote:
|=20
| > you could always compile on one machine and nfs mount the /usr/src/linux
| > and do a make modules_install from the nfs mounted directory...
|=20
| The way I've always managed this sort of thing is to tar up your kernel s=
ource,
| transfer it to the "compile box" however you please, then do all the comp=
ile
| steps except the "make modules_install" and the copying of the kernel ima=
ge.
| Then tar up the compiled source tree, transfer it over to the box you wan=
t to
| install on, untar it, and do the rest of the steps (the "make modules_ins=
tall"
| and the copying of the kernel image).  Just make sure that all the systems
| involved have about the same system time, else you'll get the message, "C=
lock
| skew detected.  Your build may be incomplete."
|=20
| One day I managed to get egcs-2.91.66 to compile against glibc-2.2, and I=
 never
| had to do that stuff again. ;)
|=20
| Kelledin
|=20
| bash-2.05 $ kill -9 1
| init: Just what do you think you're doing, Dave?
|=20
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
`----[ End Quote ]---------------------------

--=20
Gabriel Rocha (grocha@onesecure.com) - 1-877-4-1SECURE
OneSecure, Inc. Sunnyvale Security Operations Center (GMT -0700)

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: 2.6.3ia

mQCNAzrYQA8AAAEEAL/fjYD12U8QNO0PJX30zYd+0Wg1aZq+jPp34hTiMXrGg2bv
VE2hwrcz4iILCaQ5KlncteycMx6VL7u0tnIkxnT0M8fAPuS4VpqB/tS/mr3RcHLa
52+TRZ45KnZt/6pp+pc9zJM8STJvGatfF+YPYKtzEM3mFL4OEnMJdtsEFkx1AAUT
tCRHYWJyaWVsIFJvY2hhIDxncm9jaGFAb25lc2VjdXJlLmNvbT6JAJUDBRA62EAP
cwl22wQWTHUBATrVA/9Z+/pUsd0nV6ZtOn014Q9hJ1TUzhzVcNVF1zUufTHTwLO1
gnKaomNj1Fb+pwGK3ZxNqomUTAnCXCU3HxQ0DkG8OIjzuOIr08Lv57pA9u/yjlTR
IOV5REUNFWD0ogKLAlVG9wp3IsSgntjToB/rj75siVrBapqzbgR+Dcs3nb8Ijg=3D=3D
=3DHwqX
-----END PGP PUBLIC KEY BLOCK-----

--P7Tqkd/m/Jnohiaz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3in

iQCVAwUBOy/xc3MJdtsEFkx1AQE7/gQAkizxHBSdLk2zJmEsw48lesXDWaR4/ayz
I/rM/nqBHcEwypHLXMHNY0dzfEJK3JOAGxNWvC6BiqAvnEKh1G/lbZnAZhGv8ISM
M8j/DeP9I2I3+032FfP3QXCD01XYKoCSJip80hBNiVdsMrArqF2haJrAdBgTWkgZ
KYhxKbhC2RA=
=QsKL
-----END PGP SIGNATURE-----

--P7Tqkd/m/Jnohiaz--
