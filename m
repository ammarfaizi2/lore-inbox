Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUJQPIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUJQPIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUJQPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:08:36 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:52639 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S269163AbUJQPH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:07:27 -0400
Date: Sun, 17 Oct 2004 17:07:23 +0200
From: martin f krafft <madduck@debian.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: mkinitrd in a chroot on 2.6
Message-ID: <20041017150723.GA7659@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Organization: Debian GNU/Linux
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Debian kernels create an initrd during the post-installation
phase. When installing a kernel package in a chroot (e.g. for
bootstrapping a new machine) using the 2.6.8.1 kernel, the machine
hangs itself up. Messages about __find_get_block_slow failing scroll
by the screen at fast pace, and previous SSH sessions into the box
are dead. If I use 2.4.27, this does not happen.

Would you have an idea what's causing this?

--=20
Please do not CC me when replying to lists; I read them!
=20
 .''`.     martin f. krafft <madduck@debian.org>
: :'  :    proud Debian developer, admin, and user
`. `'`
  `-  Debian - when you have better things to do than fixing a system
=20
Invalid/expired PGP subkeys? Use subkeys.pgp.net as keyserver!

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcoqrIgvIgzMMSnURAqffAJ9lsThRPnf5fOpd95KjBuDhZyuEjwCggc2i
/7vlbFSE3VVz3KcNB5s4Yp8=
=n33b
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
