Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267567AbSKQTkz>; Sun, 17 Nov 2002 14:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbSKQTkz>; Sun, 17 Nov 2002 14:40:55 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:35602 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S267567AbSKQTkx>;
	Sun, 17 Nov 2002 14:40:53 -0500
Date: Sun, 17 Nov 2002 20:47:45 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: ALI 1533 / hang on boot / vaio c1mhp / 2.4.19 + acpi backport
Message-ID: <20021117194745.GA1281@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i am seeing a hang on boot on a Crusoe based Vaio C1MHP when enabling
the ALI IDE Driver:

These are the last lines:

Unform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33Mhz system bus speed for PIO modes: override with idebus=3D=
xx
ALI15X3: IDE controller on PCI bus 00 dev 80
 pci_irq-0293 [05] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:10.0
PCI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later

Kernel 2.4.19 + acpi backport + swsusp=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE91/JhUaz2rXW+gJcRAjPwAKCGSG3Bm/D85RJvsQgN1b1P1bMBugCglGDw
uhoaVlLYARZiXQIoExN+odU=
=Xk6B
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
