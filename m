Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDMXlc (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTDMXlc (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:41:32 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:49935 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262689AbTDMXla (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 19:41:30 -0400
Date: Sun, 13 Apr 2003 16:53:18 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Config problem
Message-ID: <20030413165318.D28643@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm not sure where the error is, but...

In 2.5.67, you can configure the tulip or winbond driver as modules and the
CRC library as built-in, but it doesn't work -- the CRC functions aren't
visible to the modules at load-time.  It compiles just fine, except for
depmod complaining at the end.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I think the problem is there's a nut loose on your keyboard.
					-- Greg to Customer
User Friendly, 1/5/1999=20

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+mfhuIjReC7bSPZARAg1DAKCDV9CtR8u/Uiu5v6ZSEfrgtzF/WgCfXTNw
5/kalaVRXR318ei+jJuP0rc=
=7+MD
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
