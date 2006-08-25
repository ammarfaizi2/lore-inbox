Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWHYLFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWHYLFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 07:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHYLFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 07:05:12 -0400
Received: from mail.goelsen.net ([195.202.170.130]:51914 "EHLO
	power2u.goelsen.net") by vger.kernel.org with ESMTP
	id S1751451AbWHYLFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 07:05:10 -0400
X-Envelope-From: michael.monnerie@it-management.at
X-Envelope-From: michael.monnerie@it-management.at
From: Michael Monnerie <michael.monnerie@it-management.at>
Organization: it-management http://it-management.at
To: linux-kernel@vger.kernel.org
Subject: Bug: sch_teql in 2.6.18-rc3 on Athlon64x2 SMP
Date: Fri, 25 Aug 2006 13:01:09 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2140291.xIS9QfUJHV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608251301.10069@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2140291.xIS9QfUJHV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I tried using the TEQL network device for load balancing, but it=20
causes a kernel panic when the network cable is unpluggeg from the=20
network card (forcedeth driver).

It was an MSI Motherboard with AMD Athlon64x2, stock SMP kernel=20
2.6.18-rc3, and two forcedeth onboard network cards. If you need other=20
info, please contact me per e-mail, I'm not on this list. I use the=20
bonding driver now, works without a glitch.=20

Here are two links to pictures (crash screen foto made with handy, not=20
best quality, but mostly readable):
http://zmi.at/x/teql-crash.jpg
http://zmi.at/x/teql-crash2.jpg

Thank you guys for the (otherwise) great kernel!

mfg zmi
=2D-=20
// Michael Monnerie, Ing.BSc    -----      http://it-management.at
// Tel: 0676/846914666                        .network.your.ideas.
// PGP Key:        "curl -s http://zmi.at/zmi3.asc | gpg --import"
// Fingerprint: 44A3 C1EC B71E C71A B4C2  9AA6 C818 847C 55CB A4EE
// Keyserver: www.keyserver.net                 Key-ID: 0x55CBA4EE

--nextPart2140291.xIS9QfUJHV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE7th2yBiEfFXLpO4RAg7sAJ9p2liYuRgmYIf3xpy6YncMJB5AVwCeMBJ7
QN5fvEF2yFzBQyYnoYkm46c=
=8LUK
-----END PGP SIGNATURE-----

--nextPart2140291.xIS9QfUJHV--
