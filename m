Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSFDLnl>; Tue, 4 Jun 2002 07:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSFDLnk>; Tue, 4 Jun 2002 07:43:40 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:29702 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S315928AbSFDLnj>; Tue, 4 Jun 2002 07:43:39 -0400
Date: Tue, 4 Jun 2002 14:41:12 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Padraig Brady <padraig@antefacto.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Need help tracing regular write activity in 5 s interval
Message-ID: <20020604144112.H28425@alhambra.actcom.co.il>
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org> <3CFCA2B0.4060501@antefacto.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2002 at 12:21:20PM +0100, Padraig Brady wrote:
> Matthias Andree wrote:

> > So: is there any trace software that can tell me "at 15:52:43.012345,
> > process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> > detail so I can figure if it's just an atime update -- as with svscan --
> > or a write access)? And that is NOT to be attached to a specific process
> > (hint: strace is not an option).

> This thread may be of interest:
> http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D101600745431992&w=3D2
>=20
> It's very awkward to analyse things like this at present.
> For user -> kernel you could use something like syscalltrack.

Just a short note to mention that if you want to try and trace this
activity with syscalltrack, you will want to grab the latest cvs
version - I commited read(2)/write(2) support a few hours ago.=20

Hope this helps,=20
Muli.=20
--=20
Sterday 13 Forelithe 7466

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE8/KdYKRs727/VN8sRAm4zAJ41ilEuyzx/Rpxp8m8RNsfJKXjI2wCgto00
miOrWf4ZKM3q8LLMkjrtjAw=
=biR3
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
