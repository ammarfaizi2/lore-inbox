Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbSJAUZ3>; Tue, 1 Oct 2002 16:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSJAUZ3>; Tue, 1 Oct 2002 16:25:29 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:36267 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S262237AbSJAUZ2>; Tue, 1 Oct 2002 16:25:28 -0400
Date: Tue, 1 Oct 2002 22:30:53 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.40 with gameport driver
Message-Id: <20021001223053.362be4c9.us15@os.inf.tu-dresden.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; Linux 2.4.20-pre7 i686)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.r6rvz?Ta1NrAJU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.r6rvz?Ta1NrAJU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

Linux 2.5.40 oopses on my machine with the following call trace:

analog_decode + 0x21f / 0x370
analog_init_device + 0x2cb / 0x3e0
analog_connect + 0xa6 / 0xd0
gameport_find_dev + 0x45 / 0x50
emu_probe + 0x122 / 0x190
pci_device_probe + 0x5e / 0x70
probe + 0x23 / 0x30
found_match + 0x2d / 0x70
do_driver_attach + 0x5c / 0x60
...

I had to copy these by hand because I don't have a serial console.
More info and .config available on request.

Regards,
-Udo.

--=.r6rvz?Ta1NrAJU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9mgX/nhRzXSM7nSkRAizEAJ0SktfmHDwSJT7k+rtg5XDkWpKE4ACfVEhj
nvQG/C1zpRTrrqAe7U7vzfo=
=hQEQ
-----END PGP SIGNATURE-----

--=.r6rvz?Ta1NrAJU--
