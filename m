Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbTFVTcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTFVTcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:32:36 -0400
Received: from mx.laposte.net ([213.30.181.11]:26559 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S265792AbTFVTce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:32:34 -0400
Subject: Re: linux-2.4.21 released
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZdVjSe5RMWFtELa96mkZ"
Organization: Adresse personnelle
Message-Id: <1056311197.3679.13.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 22 Jun 2003 21:46:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZdVjSe5RMWFtELa96mkZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

***

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D105572386027023&w=3D2

Nobody replied but let me do my last report.

> I just tested with 2.4.21. With IO-APIC everything worked
> except the ethernet.

My ECS K7VTA3 5.0C is useless with Linux since I can't get
ethernet to work with IO-APIC, and without it modprobe usb-uhci
just freezes everything. It may be a broken motherboard. I
can't believe all 5.0 have so many problems, but...

...I wonder what's so different in Windows XP. As I reported
ethernet and USB work together there.

***

Just take a look at:

http://bugzilla.kernel.org/show_bug.cgi?id=3D10
and the children bug
http://bugzilla.kernel.org/show_bug.cgi?id=3D71

VIA IOAPIC/ACPI brokeness (wrt USB/ethernet) has been known and reported
for a long time (8 months at least since the initial bug reports predate
kernel bugzilla). Unfortunately that didn't stop the 2.5 changes to be
backported to 2.4, and people hit it every other week now.

(and I fear it was even removed from the 2.6 must-fix list after
figuring in a few of its versions)

Both 2.4 & 2.5 are totally broken with VIA, while 2.4-ac used to work
fine last year.

Cheers,

--=20
Nicolas Mailhot

--=-ZdVjSe5RMWFtELa96mkZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+9gecI2bVKDsp8g0RAkK9AJ96G4vkiVhh4I5bPPZ6lhdmZZG3OACg3ehd
OCw5UH45UbKinWunp4b9TFU=
=J/4c
-----END PGP SIGNATURE-----

--=-ZdVjSe5RMWFtELa96mkZ--

