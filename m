Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUBKHLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 02:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBKHLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 02:11:25 -0500
Received: from caffeine.cafuego.net ([210.8.121.71]:23772 "EHLO
	caffeine.cc.com.au") by vger.kernel.org with ESMTP id S261812AbUBKHLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 02:11:24 -0500
Subject: 2.6.2 PPC ALSA snd-powermac
From: Peter Lieverdink <peter@cc.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OG2Po03b03euddu+Pa8g"
Organization: Creative Contingencies Pty. Ltd.
Message-Id: <1076483508.13791.6.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 18:11:48 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OG2Po03b03euddu+Pa8g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Is it just me or does 'make menuconfig' in kernel 2.6.2 on ppc not give
me an option to enable i2c? It's supposed to be in Character Devices,
no? The ALSA snd-powermac module needs i2c and upon a 'modprobe
snd-powermac' spews forth:

Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_smbus_write_block_data
Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_add_driver
Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_smbus_write_byte_data
Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_del_driver
Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_detach_client
Feb 10 17:47:25 chocomel kernel: snd_powermac: Unknown symbol
i2c_attach_client

- P.


--=-OG2Po03b03euddu+Pa8g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKdW0f34AjKyA6C4RApFvAKDUy+kPepXpZGU+CSBE0NZYCzNbbQCeOY8r
MaATFkpozQejNH4EDnU/05s=
=l+ZQ
-----END PGP SIGNATURE-----

--=-OG2Po03b03euddu+Pa8g--

