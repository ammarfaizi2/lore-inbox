Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUAPGFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUAPGFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:05:42 -0500
Received: from mcgroarty.net ([64.81.147.195]:5249 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S265285AbUAPGFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:05:40 -0500
Date: Fri, 16 Jan 2004 00:05:38 -0600
To: linux-kernel@vger.kernel.org
Subject: Highpoint 374 and drives recognized, but no drives/channels revealed
Message-ID: <20040116060538.GC2174@mcgroarty.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With 2.6.0, the hpt366 module seems to recognize the 8 drives attached
to my dual hpt374 controller, however no drives are visible. I should
have ide2 through ide5.

Have others run into a similar problem?

$ cat /proc/ide/hpt366
                             HighPoint HPT366/368/370/372/374

Controller: 0
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-66

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              yes            yes               yes
Mode:           UDMA             UDMA           UDMA              UDMA

Controller: 1
Chipset: HPT374
--------------- Primary Channel --------------- Secondary Channel --------------
Enabled:        yes                             yes
Cable:          ATA-66                          ATA-33

--------------- drive0 --------- drive1 ------- drive0 ---------- drive1 -------
DMA capable:    yes              yes            yes               yes
Mode:           UDMA             UDMA           UDMA              UDMA


$ ls -lA /proc/ide
-r--r--r--    1 root     root            0 Jan 15 23:33 drivers
lrwxrwxrwx    1 root     root            8 Jan 15 23:33 hda -> ide0/hda
lrwxrwxrwx    1 root     root            8 Jan 15 23:33 hdb -> ide0/hdb
lrwxrwxrwx    1 root     root            8 Jan 15 23:33 hdc -> ide1/hdc
lrwxrwxrwx    1 root     root            8 Jan 15 23:33 hdd -> ide1/hdd
-r--r--r--    1 root     root            0 Jan 15 23:33 hpt366
dr-xr-xr-x    4 root     root            0 Jan 15 23:33 ide0
dr-xr-xr-x    4 root     root            0 Jan 15 23:33 ide1
-r--r--r--    1 root     root            0 Jan 15 23:33 via

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAB38y2PBacobwYH4RAq+4AJ4xekTP02jA0QTMHaQoT9BQmDa3dQCfZHhi
qW7rWA8uPNWuVii9vCPhP2k=
=45ER
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
