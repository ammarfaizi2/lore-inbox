Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUBGXma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUBGXma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:42:30 -0500
Received: from outmx2.frognet.net ([69.58.21.51]:4741 "HELO bert.frognet.net")
	by vger.kernel.org with SMTP id S261464AbUBGXm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:42:28 -0500
Subject: Sound and multiple X-servers
From: "John J. Foster" <festus@frognet.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5+748GEPhWw0CYjUN+f0"
Organization: Representing the Mambo
Message-Id: <1076197321.8976.3.camel@Highway-61>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 07 Feb 2004 18:42:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5+748GEPhWw0CYjUN+f0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good evening,

Could someone please point me to the correct resources regarding proper
setup of the various sound devices (/dev/cdrom, /dev/mixer, etc...) and
multiple X servers/sessions? I realize this is not the proper group, but
I have been searching google, the XFree86 website, ALSA website,
newsgroups, etc... and anywhere else I can think of on and off for a few
months now. I'm currently running FedoraCore on an ASUS A7N8X Deluxe
motherboard, but I don't really think the particular hardware or version
of Linux is the problem. I hope it's just a missed configuration issue.
Each of these devices seems to only be available to the first X session
to logon.
I've bypassed this restriction for CD Audio by creating device files for
all 4 users of this machines, and then configuring their preferred
cd-player app to poing at their device file. It works fine. Any
logged-in user can now play cd's.

brw-------    1 bird     disk      11,   0 Dec 31 18:20 /dev/cd-bird
brw-------    1 festus   disk      11,   0 Dec 31 18:15 /dev/cd-festus
brw-------    1 kayde    disk      11,   0 Jan  8 21:09 /dev/cd-kayde
brw-------    1 monet    disk      11,   0 Dec 31 18:19 /dev/cd-monet

My problem now is /dev/mixer, I think. Only the first logged-in user
gets any system sounds.

Before I go further, am I missing something obvious?

Please Cc: me !
Thank you all in advance,
festus

--=-5+748GEPhWw0CYjUN+f0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAJXfJ4FEnevDNLQ4RAo4iAKCrbn0egNd92ejVWp8cWddkPrv0EQCdFeyT
+51Nxsw5Yf2Xj5hdV/ZxpHo=
=BqRs
-----END PGP SIGNATURE-----

--=-5+748GEPhWw0CYjUN+f0--

