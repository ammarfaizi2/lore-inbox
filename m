Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRBIWSp>; Fri, 9 Feb 2001 17:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbRBIWSf>; Fri, 9 Feb 2001 17:18:35 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:21500 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S130873AbRBIWSV>;
	Fri, 9 Feb 2001 17:18:21 -0500
Date: Fri, 9 Feb 2001 14:18:12 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Ashish Gupta <gashish@cse.iitk.ac.in>
Cc: kernelnewbies@humbolt.nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: problem in BOGOmips
Message-ID: <20010209141812.A3496@turbolinux.com>
In-Reply-To: <3A6C802C.9380961A@earthlink.net> <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.LNX.4.04.10102100210150.12228-100000@csews12.cse.iitk.ac.in>; from Ashish Gupta on Sat, Feb 10, 2001 at 02:35:05AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

the bogomips algorithm changed between kernels. Now it uses the tsc registe=
r. Your
bogomips should typically be about 2*processor mhz.

On Sat, Feb 10, 2001 at 02:35:05AM +0530, Ashish Gupta wrote:
> Hi,
> 	I want to use bogomips as the indicator of CPU capability for
> different architectures. I have found following values from /proc/cpuinfo
> for different CPUs.
>=20
> 	MHz		bogomips version
> 	233 intel	233	 2.2.9, 2.0.36
> 	166 intel	331	 2.2.9
> 	450 AMD-K6	900	 2.2.14
> 	800 intel	1600	 2.2.16
>=20
> Why there is a exceptional behaviour of bogomips for 233 intel ?
> If there is some patch or changes then please indicate so that i can use
> it.=20
>=20
> Thanks in advance
> Ashish Gupta
>=20
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | I've got a COUSIN who works in the GARMENT=20
of a GNU generation   -o)  | DISTRICT ...=20
Kernel 2.4.0-ac4      /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6hGyk5UrYeFg/7bURAsruAJ9sib8yWl6IBnpmHHOj0oSOF4jn9QCfaFmi
lmNEAAPAJgtxXDtqV7ebJRo=
=wf3L
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
