Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTBBNZl>; Sun, 2 Feb 2003 08:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTBBNZl>; Sun, 2 Feb 2003 08:25:41 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:4883 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265249AbTBBNZk>; Sun, 2 Feb 2003 08:25:40 -0500
Date: Sun, 2 Feb 2003 14:35:01 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Defect (Bug) Report
Message-ID: <20030202133501.GA32041@arthur.ubicom.tudelft.nl>
References: <20030202011223.GC5432@morningstar.nowhere.lie> <1044178961.16853.9.camel@irongate.swansea.linux.org.uk> <20030202124911.GC30830@arthur.ubicom.tudelft.nl> <1044195694.16853.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <1044195694.16853.22.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2003 at 02:21:35PM +0000, Alan Cox wrote:
> On Sun, 2003-02-02 at 12:49, Erik Mouw wrote:
> > Exact BIOS revision doesn't seem to matter. Any more suggestions?
>=20
> BIOS revision matters too. With 1004 you need to set MP 1.1 not MP 1.4
> and APIC works reliably. With 1007 it seems that isnt needed but people
> report weird hangs. 1004 also won't POST with a broadcom ethernet card
> in it.

Yes, I've seen weird hangs with 1007 and MP 1.4. "noapic" fixes it. Do
you suggest using MP 1.1 even with 1007?

> The proper fix for the PS/2 mouse/IDE problem appears to be always
> mapping out the page at 636-640K. Andi posted an ugly patch to handle
> that, but doing it cleanly is trickier.=20

I think I missed his patch, but a dirty trick I could think of would be
to put a "reserved" entry in the e820 RAM map we got from the BIOS.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org
WWW: http://www-ict.its.tudelft.nl/~erik/

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+PR6F/PlVHJtIto0RAutqAKCGFO/it5sXRV+PRgY4kcQOPyVvtACfejuY
bOAKrQ3aTZmJudkzNg0o4fg=
=EnZN
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
