Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVAMWld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVAMWld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVAMWiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:38:08 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:40379 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261715AbVAMWhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:37:13 -0500
Subject: Re: Linux 2.6.11-rc1 (ACPI related problems)
From: Hanspeter Kunz <hkunz@ailab.ch>
Reply-To: hkunz@ailab.ch
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105515143.2734.6.camel@lb.loomes.de>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
	 <1105515143.2734.6.camel@lb.loomes.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CvYsw6aWfPHjDOT+No55"
Date: Thu, 13 Jan 2005 23:37:12 +0100
Message-Id: <1105655832.8599.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CvYsw6aWfPHjDOT+No55
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

And I see these errors on i386:

ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_.EC8C] (Node c17ee940), AE_AML_BUFFER_LIMIT
ACPI-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_.EC04] (Node c17eeba0), AE_AML_BUFFER_LIMIT
ACPI-1138: *** Error: Method execution failed [\_SB_.ECPF] (Node
c17ded20), AE_AML_BUFFER_LIMIT
ACPI-1138: *** Error: Method execution failed [\_SB_.BATA._BIF] (Node
c17f3c00), AE_AML_BUFFER_LIMIT

consequently, my /proc/acpi/battery/ is empty.=20

Further, when I go to S3 the system does not enter sleep mode (as it did
with 2.6.10).

Otherwise it runs without problems.

cheers,
Hp.

On Wed, 2005-01-12 at 08:32 +0100, Markus Trippelsdorf wrote:
> I see these errors in dmesg on an AMD_64:
>=20
> ACPI: Subsystem revision 20041210
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
>     ACPI-1138: *** Error: Method execution failed [\MCTH] (Node
> ffff81003ff8ecc0), AE_AML_BUFFER_LIMIT
>     ACPI-1138: *** Error: Method execution failed [\OSFL] (Node
> ffff81003ff8ed00), AE_AML_BUFFER_LIMIT
>     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._S3D]
> (Node ffff81003ff82140), AE_AML_BUFFER_LIMIT
>     ACPI-0158: *** Error: Method execution failed [\_SB_.PCI0._S3D]
> (Node ffff81003ff82140), AE_AML_BUFFER_LIMIT
>=20
> But the system is running fine AFAICT.
>=20
> __ =20
> Markus
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Hanspeter Kunz                  Artificial Intelligence Laboratory
Ph.D. Student                   Department of Information Technology
Email: hkunz@ailab.ch           University of Zurich
Tel: +41.(0)44.63-54306         Andreasstrasse 15, Office 2.12
http://ailab.ch/people/hkunz    CH-8050 Zurich, Switzerland

Spamtraps: hkunz.bogus@ailab.ch hkunz.bogus@ifi.unizh.ch
---
It's not whether you win or lose, it's how you place the blame.

--=-CvYsw6aWfPHjDOT+No55
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5vgYU6591lRWg2kRAvwXAJ4umdZpfHhE2SLn5Vs3KxbUzrHKvwCbBTzO
XqqO3B+W7Z1c0+Qn5hn0mfQ=
=2nEO
-----END PGP SIGNATURE-----

--=-CvYsw6aWfPHjDOT+No55--

