Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVEXQZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVEXQZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVEXQZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:25:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:16624 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262124AbVEXQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:24:02 -0400
Message-ID: <429353F8.5070404@punnoor.de>
Date: Tue, 24 May 2005 18:19:04 +0200
From: Prakash Punnoor <lists@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsusp and kernel 2.6.12-rc4 does not work
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig18BD7444EB0531C1640DCAA1"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig18BD7444EB0531C1640DCAA1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I haven't treid with an earlier kernel. I am using an Sony Vaio PCG-F8=DF=
07K
notebook and tried to suspend.

What goes wrong is, that the hd gets shut down before anything is written=
 to it.

I see (leaving some details out):

Stopping task:=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|
Freeing memory..done (40502 pages freed)
swsusp: Need to copy 6953 pages
swsusp: critical section/: done (6981 pages copied)
ACPI: PCI Interrupt yadda yadda.. -> IRQ 9

and there it sits. Is it really just the problem, that the hd gets shut d=
own
too early? Is there an easy way to fix this?

Thanks,

Prakash


--------------enig18BD7444EB0531C1640DCAA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCk1P4xU2n/+9+t5gRAlikAJ4oncvK6UCDKh+8HJmpivZc5INvdACeOOi4
CRLWITHNvgc+YmBKlwjoAo0=
=oRsI
-----END PGP SIGNATURE-----

--------------enig18BD7444EB0531C1640DCAA1--
