Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTHZMhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbTHZMhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:37:47 -0400
Received: from c-780372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.120]:35172
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263880AbTHZMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:37:34 -0400
Subject: [ACPI] 2.4.22, My bios is to old?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Kumlien <pomac@vapor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n5zGHIkbOk+JF52I7oVc"
Message-Id: <1061901388.7167.19.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 14:36:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n5zGHIkbOk+JF52I7oVc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I just updated $other machine to 2.4.22, and now i have several ACPI
tools screaming at me because /proc/acpi dosn't exist.
(it was running 2.4.21-pre1, it has aslo been running with several acpi
patches)

And then:
dmesg |grep ACPI
 BIOS-e820: 0000000027fec000 - 0000000027fef000 (ACPI data)
 BIOS-e820: 0000000027fff000 - 0000000028000000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI disabled because your bios is from 2000 and too old <- WTF?
ACPI: RSDP (v000 ASUS                                      ) @
0x000f6580
ACPI: RSDT (v001 ASUS   K7V      0x30303031 MSFT 0x31313031) @
0x27fec000
ACPI: FADT (v001 ASUS   K7V      0x30303031 MSFT 0x31313031) @
0x27fec080
ACPI: BOOT (v001 ASUS   K7V      0x30303031 MSFT 0x31313031) @
0x27fec040
ACPI: DSDT (v001   ASUS K7V      0x00001000 MSFT 0x0100000b) @
0x00000000
ACPI: MADT not present
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
PCI: ACPI tables contain no PCI IRQ routing entries

I assure you that this machine has been running with acpi enabled for
years without a problem. The latest bios is from "2000/08/04" according
to asus' website.

Is it me or is this check unwarranted? Or does it actually catch bad
bisoses?

PS. Keep me in the CC:
DS.

--=20
Ian Kumlien <pomac@vapor.com>

--=-n5zGHIkbOk+JF52I7oVc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/S1RM7F3Euyc51N8RAjPFAKC2hASwqfaoT5yGPc6C5VYHxo2ozQCgmi8t
goWdE8R4AigRK0/Fr4SWAAo=
=cjwk
-----END PGP SIGNATURE-----

--=-n5zGHIkbOk+JF52I7oVc--

