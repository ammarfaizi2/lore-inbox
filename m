Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSKRLqQ>; Mon, 18 Nov 2002 06:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSKRLqQ>; Mon, 18 Nov 2002 06:46:16 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:46093 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S262312AbSKRLqP>;
	Mon, 18 Nov 2002 06:46:15 -0500
Date: Mon, 18 Nov 2002 12:52:32 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALI 1533 / hang on boot / vaio c1mhp / 2.4.19 + acpi backport
Message-ID: <20021118115232.GA553@paradigm.rfc822.org>
References: <20021117194745.GA1281@paradigm.rfc822.org> <1037573400.5356.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1037573400.5356.1.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2002 at 10:50:00PM +0000, Alan Cox wrote:
> On Sun, 2002-11-17 at 19:47, Florian Lohoff wrote:
> >=20
> > Hi,
> > i am seeing a hang on boot on a Crusoe based Vaio C1MHP when enabling
> > the ALI IDE Driver:
> >=20
> > These are the last lines:
> >=20
> > Unform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33Mhz system bus speed for PIO modes: override with idebu=
s=3Dxx
> > ALI15X3: IDE controller on PCI bus 00 dev 80
> >  pci_irq-0293 [05] acpi_pci_irq_derive   : Unable to derive IRQ for dev=
ice 00:10.0
> > PCI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
> > ALI15X3: chipset revision 196
> > ALI15X3: not 100% native mode: will probe irqs later
>=20
> Try it without the ACPI first. Let me know if that also hangs

It does - With acpi=3Doff and acpi=3Doff pci=3Dbiosirq (as mentioned in that
crash). I also tried the somewhere mentioned UDMA66 force (ide0=3Data66
ide1=3Data66) which does get over this point but fails to mount the root
filesystem with IDE errors.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92NSAUaz2rXW+gJcRAkSCAJ412PD1uuyI/iidVAZqg8vIMpmqLACeOjWe
nJBMfI9285ulkKc1tqX/HtY=
=FRG5
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
