Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423003AbWJFX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWJFX0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbWJFX0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:26:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:64486 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1423003AbWJFX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:26:16 -0400
X-Sasl-enc: ymnLm3ufS8jeqYpvyyv6RgKwWd99qXqCNR/8V+9aFZFS 1160177177
Message-ID: <4526E692.207@imap.cc>
Date: Sat, 07 Oct 2006 01:28:18 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: v2.6.19-rc1 build warnings
References: <72sfz-wa-1@gated-at.bofh.it>
In-Reply-To: <72sfz-wa-1@gated-at.bofh.it>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1F69ACF0AADB591CCFB14B32"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F69ACF0AADB591CCFB14B32
Content-Type: multipart/mixed;
 boundary="------------040705020403080807070602"

This is a multi-part message in MIME format.
--------------040705020403080807070602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Building v2.6.19-rc1 on a rather ordinary, oldish i386 I see:

  Building modules, stage 2.
  MODPOST 910 modules
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.=
data: from .text between 'acpi_processor_power_init' (at offset 0x146c) a=
nd 'acpi_processor_cst_has_changed'
WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

Just thought I would let you know.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)



--------------040705020403080807070602
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYxLjQuM3Jj
MSAoTWluZ1czMikNCkNvbW1lbnQ6IFVzaW5nIEdudVBHIHdpdGggTW96aWxsYSAtIGh0dHA6
Ly9lbmlnbWFpbC5tb3pkZXYub3JnDQoNCmlEOERCUUZGSnVDNU1kQjRXaG04Ni9rUkFzU3FB
SnNHUm0rWTRmcEJrWlVBd0FwYXpSV0swcG9NVmdDZmNoVGINCnpoZjJkcFd0Q1ZEa2UyTVR5
bUNQSVVnPQ0KPUI4THgNCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQo=
--------------040705020403080807070602--

--------------enig1F69ACF0AADB591CCFB14B32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFJuaSMdB4Whm86/kRAuniAJ9TAMNapaXWtyJui/ypElPKid40UQCcDugP
W+jYEOUZr5vfK+cQQaK72KE=
=jwz7
-----END PGP SIGNATURE-----

--------------enig1F69ACF0AADB591CCFB14B32--
