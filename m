Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUBYSup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUBYStB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:49:01 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:62420 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262511AbUBYSra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:47:30 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Wed, 25 Feb 2004 13:47:24 -0500
To: linux-kernel@vger.kernel.org
Subject: bsd accounting lockups on smp 2.6.x machines
Message-ID: <20040225184724.GA2618@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i originally reported kernel oopses and locks here against 2.6.1:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107488761716255&w=3D2

then another person reported it against 2.6.2:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107697407107875&w=3D2

i just saw it happen against 2.6.3, but i couldn't capture an
oops.  it's still out there.  does anyone have any leads on what
causes it?  disabling  bsd accounting seems to aleviate the
crashes.

running tomcat's stop script (java processes) triggers it at
times for me.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPO28CGPRljI8080RAuplAJ9Wlj2ZhAtG4r0JEz1bXFa4DpgubQCfRl+d
KN3rVobXPkDzbwWFCcM0EwU=
=uqfU
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
