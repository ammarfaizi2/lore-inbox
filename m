Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUASPlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUASPlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:41:06 -0500
Received: from 82-68-84-57.dsl.in-addr.zen.co.uk ([82.68.84.57]:51877 "EHLO
	lenin.trudheim.com") by vger.kernel.org with ESMTP id S265259AbUASPlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:41:03 -0500
Subject: BK 2.6.1 Kernel
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5uEzI89S4L95fk0S5FDV"
Organization: Trudheim Technology Limited
Message-Id: <1074526887.5748.8.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Mon, 19 Jan 2004 15:41:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5uEzI89S4L95fk0S5FDV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

System is a Thinkpad X31, Pentium-M with 512MB RAM.

Today I pulled the latest change-sets from
http://linux.bkbits.net:8080/linux-2.5 and
http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.1 and built that
kernel. (.config available on request).

This kernel does boot, ish... It gets as far as loading the ACPI modules
towards the end of the boot procedure, then locks the machine up
completely. Alt+SysRq+{s,u}, does not work, Alt+SysRq+b does reboot the
box, so not a complete hard hang with loss of interrupts etc.

There is no debug output as the machine hangs so suddenly. Side effect
of this hang is that the /var filesystem, reiserfs, gets halfly hosed.
Ordinary fsck fails and I get dropped to a shell to fix it manually. I
am using LVM2 and device-mapper for the filesystems, and my compiled
2.6.0 kernel still works, so I will use that for the time being.

If there is any patches for ACPI, I will happily try them.

Cheers,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-5uEzI89S4L95fk0S5FDV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAC/qmLYywqksgYBoRAoPTAJ0Yozc+ZdHuKwPZP4ntA4M8iMlIjACg2N/z
7k/xXFbeAvoQyXb5cpXS7vk=
=C+kF
-----END PGP SIGNATURE-----

--=-5uEzI89S4L95fk0S5FDV--
