Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWIGT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWIGT5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWIGT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:57:42 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:48006 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751837AbWIGT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:57:41 -0400
Date: Thu, 07 Sep 2006 15:37:47 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: [linux-usb-devel] [PATCH] driver for mcs7830 (aka DeLOCK) USB
	ethernet adapter
In-reply-to: <20060904064042.2E40719E185@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
To: David Brownell <david-b@pacbell.net>
Cc: arnd@arndb.de, support@moschip.com, supermihi@web.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <1157657867.4388.5.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.7.92 (2.7.92-7.fc6)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-i0V1NeXxFqvnwGClenqc"
References: <200608071500.55903.arnd.bergmann@de.ibm.com>
	<200608202207.39709.arnd@arndb.de> <200609020338.54932.david-b@pacbell.net>
	<200609021951.40470.arnd@arndb.de>
	<20060904064042.2E40719E185@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i0V1NeXxFqvnwGClenqc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-09-03 at 23:40 -0700, David Brownell wrote:

>=20
> > Going through the ethtool operations, I think that it should be
> > possible to implement a few of them, including ETHTOOL_GREGS,
> > ETHTOOL_GEEPROM, ETHTOOL_SEEPROM, ETHTOOL_NWAY_RST and ETHTOOL_GPERMADD=
R.
> > Do you think these should be done?
>=20
> I've not got much use for those, but maybe the netdev folk would
> care.  That's probably not enough to hold up any merge.

Definitely not showstoppers, but nice touches just to ensure that all
things work as expected.  The ones of most importance as I see it are
the get/set_settings ones, which you can just pass-thru to the
mii_ethtool_Xset() calls and get_drvinfo().  All others are somewhat
optional and do vary from device to device.

--=20
David Hollis <dhollis@davehollis.com>

--=-i0V1NeXxFqvnwGClenqc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFAHULxasLqOyGHncRAvjPAKCMwOM2EBBZW1iam58PLgu9GENgUwCdF4eZ
mm81gRDXm6Qd2SBQjKpa4JQ=
=8ERE
-----END PGP SIGNATURE-----

--=-i0V1NeXxFqvnwGClenqc--

