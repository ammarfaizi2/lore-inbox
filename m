Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRIBUWL>; Sun, 2 Sep 2001 16:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRIBUWB>; Sun, 2 Sep 2001 16:22:01 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:19332 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S268957AbRIBUVo>; Sun, 2 Sep 2001 16:21:44 -0400
Date: Sun, 2 Sep 2001 15:21:37 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Editing-in-place of a large file
Message-ID: <20010902152137.L23180@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TXIPBuAs4GDcsx9K"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TXIPBuAs4GDcsx9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I would like to take an extremely large file (multi-gigabyte) and edit
it by removing a chunk out of the middle.  This is easy enough by
reading in the entire file and spitting it back out again, but it's
hardly efficent to read in an 8GB file just to remove a 100MB segment.

Is there another way to do this?

Is it possible to modify the inode structure of the underlying
filesystem to free blocks in the middle?  (What to do with the half-full
blocks that are left?)  Has anyone written a tool to do something like
this?

Is there a way to do this in a filesystem-independent manner?

Thanks,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--TXIPBuAs4GDcsx9K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuSlNEACgkQjwioWRGe9K3DzgCgh+FCYf5rXWizoCsG7hY4ul8e
VTEAn33UdmzGxPsyvTsGAkjrUB54KAGp
=8Zsa
-----END PGP SIGNATURE-----

--TXIPBuAs4GDcsx9K--
