Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbTBBMkB>; Sun, 2 Feb 2003 07:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbTBBMkB>; Sun, 2 Feb 2003 07:40:01 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:62226 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265238AbTBBMkA>; Sun, 2 Feb 2003 07:40:00 -0500
Date: Sun, 2 Feb 2003 13:49:11 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Defect (Bug) Report
Message-ID: <20030202124911.GC30830@arthur.ubicom.tudelft.nl>
References: <20030202011223.GC5432@morningstar.nowhere.lie> <1044178961.16853.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <1044178961.16853.9.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2003 at 09:42:41AM +0000, Alan Cox wrote:
> > Any other suggestions, or recommendations to get more info?
>=20
> Three starting points
>=20
> 1.  Run memtest86 on the box for a bit. I don't think its bad RAM however
> 2.  Plug in a PS/2 mouse if the box doesn't have one already. That avoids
> a hardware flaw on the AMD that we don't current work around in software
> 3.  Check if 2.4.20 behaves the same way. I think it may fix your short
> pauses but I don't think its going to fix the hang alas. It would be
> useful to know however

What's the current wisdom with dual Athlon boards to get them stable?
This is my list so far (for Asus A7M266-D):

- Plug in a PS/2 mouse even though you don't use it. It fixes certain
  hardware problems.
- Select "PnP OS =3D no" in the BIOS so all PCI devices (even the ones
  behind the PCI-PCI bridge) get properly initialised.
- Boot Linux with "noapic" to avoid random hangs.

Exact BIOS revision doesn't seem to matter. Any more suggestions?


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
WWW: http://www-ict.its.tudelft.nl/~erik/

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+PRPH/PlVHJtIto0RAqyTAJ9euvchlnraUdbnMU+1hkHLHtxyzwCgjjNC
aqauIXukIvFPeO3L9Ckjnck=
=V2Ji
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
