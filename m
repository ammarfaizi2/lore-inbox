Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278961AbRKAOOc>; Thu, 1 Nov 2001 09:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278970AbRKAOOW>; Thu, 1 Nov 2001 09:14:22 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16855 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278961AbRKAOON>; Thu, 1 Nov 2001 09:14:13 -0500
Date: Thu, 1 Nov 2001 14:14:12 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: driver initialisation order problem
Message-ID: <20011101141412.R20398@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="NffpD3bBbNaSNdk0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NffpD3bBbNaSNdk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

drivers/char depends on drivers/parport (lp requires parport)
drivers/parport depends on drivers/char (parport_serial requires serial)

How should this dependency be expressed?  The link order of
drivers/char and drivers/parport isn't enough.

Tim.
*/

--NffpD3bBbNaSNdk0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE74VizyaXy9qA00+cRAsnLAJwMBlZnlyg61VVoG3ECwlj6ZLI65ACgoXun
mLwXqg78I4zsY8GPe/Thm+I=
=6d2c
-----END PGP SIGNATURE-----

--NffpD3bBbNaSNdk0--
