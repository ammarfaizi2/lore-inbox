Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310415AbSCBSrQ>; Sat, 2 Mar 2002 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310417AbSCBSrH>; Sat, 2 Mar 2002 13:47:07 -0500
Received: from konza.flinthills.com ([64.39.200.1]:57577 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S310415AbSCBSqu>; Sat, 2 Mar 2002 13:46:50 -0500
Subject: Re: hdc: lost interrupt
From: Derek J Witt <djw@flinthills.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1015092400.1336.1.camel@saiya-jin>
In-Reply-To: <Pine.LNX.4.33.0203021113260.22434-100000@coffee.psychology.mcmaster.ca> 
	<1015092400.1336.1.camel@saiya-jin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-mhagcPjTHABwvdXWCxgC"
X-Mailer: Evolution/1.0.2 
Date: 02 Mar 2002 12:45:34 -0600
Message-Id: <1015094734.470.2.camel@saiya-jin>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mhagcPjTHABwvdXWCxgC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yeah, I do have APIC enabled. I'm using the local APIC and the IO-apic.=20
My Celeron PPGA 500 does have an apic. Could the apic be causing the
interrupt timing problems?  Sorry about the double post.


On Sat, 2002-03-02 at 12:06, Derek J Witt wrote:
> yeah, I am. My celeron 500 PPGA has APIC. Oh, could the apic causing
> interrupt timing problems?
>=20
>=20
> On Sat, 2002-03-02 at 10:16, Mark Hahn wrote:
> > > losing IDE interrupts.  I tried disabling multimode in makeconfig but=
 to
> >=20
> > are you using the local apic?
> >=20
> > here are the set settings I use on my via-based machines (which are all=
 stable):
> > CONFIG_IDE=3Dy
> > CONFIG_BLK_DEV_IDE=3Dy
> > CONFIG_BLK_DEV_IDEDISK=3Dy
> > CONFIG_IDEDISK_MULTI_MODE=3Dy
> > CONFIG_BLK_DEV_IDECD=3Dy
> > CONFIG_BLK_DEV_IDEPCI=3Dy
> > CONFIG_IDEPCI_SHARE_IRQ=3Dy
> > CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
> > CONFIG_BLK_DEV_ADMA=3Dy
> > CONFIG_IDEDMA_PCI_AUTO=3Dy
> > CONFIG_BLK_DEV_IDEDMA=3Dy
> > CONFIG_BLK_DEV_VIA82CXXX=3Dy
> > CONFIG_IDEDMA_AUTO=3Dy
> > CONFIG_BLK_DEV_IDE_MODES=3Dy
> >=20
> > > Has anyone else with a Via chipset been able to boot into 2.5.x witho=
ut having these interrupt problems? Any suggestions will be helpful.
> >=20
> > I confess I haven't ventured to use 2.5 on any machines.
> >=20
> >=20
> --=20
> **  Derek J Witt                                              **
> *   Email: mailto:djw@flinthills.com                           *
> *   Home Page: http://www.flinthills.com/~djw/                 *
> *** "...and on the eighth day, God met Bill Gates." - Unknown **
--=20
**  Derek J Witt                                              **
*   Email: mailto:djw@flinthills.com                           *
*   Home Page: http://www.flinthills.com/~djw/                 *
*** "...and on the eighth day, God met Bill Gates." - Unknown **

--=-mhagcPjTHABwvdXWCxgC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8gR3OOyrxImZB9j4RAvRsAKCrtLttpwhnIPvOnkM6wB8KqFZi1QCdEzXh
NRmwCmGXe7C9rhf810EJyiA=
=O1za
-----END PGP SIGNATURE-----

--=-mhagcPjTHABwvdXWCxgC--
