Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWJIVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWJIVsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWJIVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:48:51 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:29654 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S964883AbWJIVsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:48:50 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: linux-kernel@vger.kernel.org
Subject: [2.16.19-rc1] Section mismatch warnings
Date: Tue, 10 Oct 2006 00:48:43 +0300
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4391823.htPeEAkvjT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610100048.49550.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4391823.htPeEAkvjT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

I'm not sure they are already reported but there it is;

Kernel: arch/i386/boot/bzImage is ready  (#2)
  Building modules, stage 2.
  MODPOST 1384 modules
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.da=
ta:=20
from .text between 'acpi_processor_power_init' (at offset 0x14d7)=20
and 'acpi_processor_power_exit'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.tex=
t:=20
from .text between 'fore200e_initialize' (at offset 0x21ab)=20
and 'fore200e_monitor_putc'
WARNING: drivers/atm/horizon.o - Section mismatch: reference to .init.text:=
=20
from .text between 'hrz_probe' (at offset 0x1476) and 'hrz_remove_one'
WARNING: drivers/atm/lanai.o - Section mismatch: reference to .init.text:=20
from .text between 'sram_test_pass' (at offset 0x160)=20
and 'sram_test_and_clear'
WARNING: drivers/atm/zatm.o - Section mismatch: reference to .init.text:=20
from .text after 'zatm_init_one' (at offset 0x1dcb)
WARNING: drivers/atm/zatm.o - Section mismatch: reference to .init.text:=20
from .text after 'zatm_init_one' (at offset 0x1dd8)
WARNING: drivers/net/sis900.o - Section mismatch: reference=20
to .init.text:sis900_mii_probe from .text between 'sis900_probe' (at offset=
=20
0x479) and 'sis900_default_phy'
WARNING: drivers/net/sunhme.o - Section mismatch: reference to .init.text:=
=20
from .text between 'happy_meal_pci_probe' (at offset 0x271d)=20
and 'happy_meal_pci_remove'

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart4391823.htPeEAkvjT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKsPBy7E6i0LKo6YRAtFAAJ4gGeVDtzrwrPITfJGH01OcNYj/IwCfXJR6
E3LhdNaPVxE2wAke0OucwYo=
=sePq
-----END PGP SIGNATURE-----

--nextPart4391823.htPeEAkvjT--
