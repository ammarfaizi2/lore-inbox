Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUAVTTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUAVTTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:19:11 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:23172 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264929AbUAVTTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:19:08 -0500
Date: Fri, 23 Jan 2004 08:21:45 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: A question about terminology.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074799304.12771.93.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-X1nq8hlBaXWJI2tXpCF/";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X1nq8hlBaXWJI2tXpCF/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi again.

When I began work on swapfile support, I looked for an efficient method
to store all the information on which blocks were used. The process led
me to develop something I called ranges, which Pavel later looked at and
said something like 'Oh. Extents.'

Throughout the code, I still call them ranges (I have, for example
struct range and struct rangechain). In preparation for merging, should
I go through an rename ranges to extents, or will they be okay as it is?

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-X1nq8hlBaXWJI2tXpCF/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAECLIVfpQGcyBBWkRApCNAKCYBDZrCtiOrXHia/Zl8ep/c2rwDwCeKJg1
bLvAjUxU2HuwHd8Gf/luCq4=
=CB/0
-----END PGP SIGNATURE-----

--=-X1nq8hlBaXWJI2tXpCF/--

