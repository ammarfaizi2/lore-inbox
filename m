Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTFPP2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTFPP2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:28:35 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:35745 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263971AbTFPP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:28:34 -0400
Date: Mon, 16 Jun 2003 11:38:45 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.71: unregister_netdevice for 3c574_cs and orinoco_cs
To: linux-kernel@vger.kernel.org
Message-id: <20030616153845.GA1638@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=FL5UXtIhxfXey3p5;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

reportedly this should have been fixed for orinoco_cs, but i'm still
seeing it with both my cards.  whenever i try to shutdown pcmcia, thus
rmmod the respective network device modules, i get this message
looping.

i think my pcmcia shutdown does manage to kind of give up on it and
continue most the time and shutdown, but this really does not lend
well to hotswapping these devices since they essentially can't be
reinserted after eject.  i've been seeing this problem for a while
with previous 2.5 kernels.  thanks.

unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
unregister_netdevice: waiting for eth1 to become free. Usage count =3D 1
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7eSFCGPRljI8080RAsbGAJ91MRCdbB8O86E2qV53LXwj6yxwsgCdEr43
rYHecasMncOGNZXY3Bzy0l0=
=W0Ts
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
