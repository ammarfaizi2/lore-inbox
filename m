Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVIVAHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVIVAHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 20:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVIVAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 20:07:38 -0400
Received: from idefix.CeNTIE.NET.au ([202.9.6.83]:48780 "HELO idefix")
	by vger.kernel.org with SMTP id S965185AbVIVAHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 20:07:38 -0400
Subject: Suspend to RAM broken with 2.6.13
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fev59uZf7M8MjgB6siR5"
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Thu, 22 Sep 2005 10:07:13 +1000
Message-Id: <1127347633.25357.49.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fev59uZf7M8MjgB6siR5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
seems like the longer my uptime, the more likely the problem is to occur
(which makes it hard to reproduce sometimes). This happens even with a
non-preempt kernel.
I posted my .config here
http://people.xiph.org/~jm/config-2.6.13-i386

My hardware is:
Dell Latitude D600 (Bios rev. A14)
Pentium-M 1.6 GHz / 1 GB RAM
ATI Technologies, Inc. Radeon Mobility 9000 M9 (R250 Lf)

Any idea how to solve this?

	Jean-Marc

P.S. Please CC to me as I'm not subscribed to the list.

--=20
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Universit=E9 de Sherbrooke

--=-Fev59uZf7M8MjgB6siR5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDMfWwdXwABdFiRMQRAvvCAJ0aSSmk2mIrsmuL+y74MtWu+oynBACglg3F
CBlB9RP/kbQ+jbJid1IfxlY=
=eesu
-----END PGP SIGNATURE-----

--=-Fev59uZf7M8MjgB6siR5--
