Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVD0SEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVD0SEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVD0SE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:04:29 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:40123 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261923AbVD0SEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:04:01 -0400
Subject: RE: 2.6.12-rc2-mm3 pciehp regression
From: Tom Duffy <tduffy@sun.com>
To: "Sy, Dely L" <dely.l.sy@intel.com.sun.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E04FFF546@orsmsx408>
References: <468F3FDA28AA87429AD807992E22D07E04FFF546@orsmsx408>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GGZIYVxICmSdX7JxHR9i"
Date: Wed, 27 Apr 2005 11:02:43 -0700
Message-Id: <1114624963.2221.10.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GGZIYVxICmSdX7JxHR9i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-20 at 16:34 -0700, Sy, Dely L wrote:
> This doesn't help on my system.  I tried both ways: using boot option=20
> with nosmp, and rebuilding kernel with SMP off in config file. =20
>=20
> Using nosmp, I got:
> IOAPIC [0]: Invalid reference to IRQ 0
> .
> .
> audit(....) initialized
> ide 1 : ....
> id1 1 : ports already in use, skipping
>=20
> and system halted
>=20
> Rebuilding kernel with SMP off in config file, I got:
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)

Did you ever get this fixed?  I think it requires an update to your
mkinitrd.  The one from Fedora Core 4 test 2 (4.2.9) should do the
trick.

-tduffy

--=-GGZIYVxICmSdX7JxHR9i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCb9PDdY502zjzwbwRAtx+AJ0eschuXfeg4QaNgeXtxdW/62s9aACfcZAN
SCXTSVdnT4cxrKvf6yAJav8=
=6Wn5
-----END PGP SIGNATURE-----

--=-GGZIYVxICmSdX7JxHR9i--
