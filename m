Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289794AbSAWL3r>; Wed, 23 Jan 2002 06:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289795AbSAWL3h>; Wed, 23 Jan 2002 06:29:37 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:1810 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S289794AbSAWL3Z>;
	Wed, 23 Jan 2002 06:29:25 -0500
Date: Thu, 24 Jan 2002 14:33:19 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Mario Mikocevic <mozgy@hinet.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810 TCO ?!
Message-ID: <20020124143319.A197@pazke.ipt>
In-Reply-To: <20020123111934.C9441@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
User-Agent: Mutt/1.0.1i
In-Reply-To: <20020123111934.C9441@danielle.hinet.hr>; from mozgy@hinet.hr on Wed, Jan 23, 2002 at 11:19:34AM +0100
X-Uname: Linux pazke 2.4.13-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2002 at 11:19:34AM +0100, Mario Mikocevic wrote:
> Hi,
>=20
> I would like to use i810 watchdog module (i810-tco).
>=20
> Upon modprobing I get ->
>=20
> kernel: i810 TCO timer: failed to reset NO_REBOOT flag, reboot disabled b=
y hardware

Your motherboard is crap (sorry), it is has some magic ICH pin
wired to ground and so TCO timer is disabled.

>=20
> what should I do now ?
>=20
>  - add some options to insmod ?
>  - change some option in BIOS (I can't pinpoint any)

No.

>  - change some jumper onboard ?

It is theoreticaly possible.

>  - apply some patch ?

You can only patch your motherboard ;)

>=20
>=20
> driver is 0.03 posted on this list in Oct last year.
> Kernel is latest 2.4.x (currently 18-pre4).
>=20
> lspci ->
>=20
> # lspci
> 00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and =
Memory Controller Hub (rev 02)
> 00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset G=
raphics Controller]  (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 02)
> 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 02)
> 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02)
> 00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 02)
> 00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 A=
udio (rev 02)
> 01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 0=
1)
>=20
> any other information available on request,
>=20
>=20
> TIA,
>=20

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8T/D/Bm4rlNOo3YgRAsc5AJwKdIovzGlZp7s/ckJhZ+y6v7PtJQCeKvAr
T2aOCGtMdto6GA5vOQTJ53E=
=37vj
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
