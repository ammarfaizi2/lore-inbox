Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbUDBOsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUDBOsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:48:42 -0500
Received: from mail.fdk-filmhaus.de ([212.184.83.66]:44780 "EHLO
	mail.fdk-filmhaus.de") by vger.kernel.org with ESMTP
	id S264064AbUDBOsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:48:38 -0500
Subject: powernow-k8: broken PSB
From: Christoph Terhechte <ct@fdk-berlin.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GPK6VgxApLmD3F0/Z/ar"
Message-Id: <1080917249.7252.13.camel@asahi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Apr 2004 16:47:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GPK6VgxApLmD3F0/Z/ar
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running Gentoo Linux on an Athlon 64 system (board is Asus 8KV SE
Deluxe). I was getting the "BIOS error - no PSB" message when trying to
"modprobe powernow-k8", so I upgraded to 2.6.5-rc3-mm4 which includes
Pavel Machek's new powernow-k8 driver. Theoretically, it should be
getting tables through ACPI and ignore the legacy PST/PSB tables, but
I'm still getting the same error as before and inserting powernow-k8
fails with this message:

FATAL: Error inserting powernow_k8
(/lib/modules/2.6.5-rc3-mm4/kernel/arch/x86_64/cpufreq/powernow-k8.ko):
No such device

Is there anything I need to tell the kernel explicitly to inform it not
to use the legacy method? Any kernel options I might have overlooked?

BIOS support for ACPI 2.0 is activated and APIC APIC Supprt enabled. I'm
confused about this boot message, though:

PCI bridge 00:01 from 1106 found. Setting "noapic". Overwrite with
"apic"

--=20
Christoph Terhechte <ct@fdk-berlin.de>
International Forum of New Cinema
Potsdamer Strasse 2
D-10785 Berlin
Tel: +49-30-269.55.200
Fax: +49-30-269.55.222


--=-GPK6VgxApLmD3F0/Z/ar
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAbX0BUMN/y69U3RgRAgKHAKCkVhEQjXBl6R7zcj59LTpChTVxOgCdEvi7
u/udaxJHyhSeLcdXXkRNhX4=
=hlnE
-----END PGP SIGNATURE-----

--=-GPK6VgxApLmD3F0/Z/ar--
