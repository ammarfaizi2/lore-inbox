Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267844AbTGLHUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 03:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbTGLHUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 03:20:25 -0400
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.181.13]:12416 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S267844AbTGLHUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 03:20:22 -0400
Date: Sat, 12 Jul 2003 03:27:44 -0400
From: timothy parkinson <t@timothyparkinson.com>
To: linux-kernel@vger.kernel.org
Subject: netgear f312 (natsemi) under 2.5.75
Message-ID: <20030712072744.GA225@timothyparkinson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


hi,

thought i'd give 2.5.75 a try today, and the only thing that i couldn't get
to work is my network card:

00:08.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
        Subsystem: Netgear: Unknown device f312

i'm working on a reasonably close to default slackware 9.0 box, with a working
2.4.21 kernel of my own build.

i started out by installing module-init-tools-0.9.12, and then built 2.5.75.
the module (natsemi.o) seems to load just fine with no complaints.  dhcpcd
runs, the lights flash on my cable modem, things appear to be working just
the same as 2.4.21, however dhcpcd just exits silently without bringing up
eth0.

i've tried building the driver into the kernel instead, recompiling dhcpcd,
resetting the cable modem - it works under 2.4.21 just fine, the only
variable is the kernel.  i'm completely at a loss here.

anyone else seeing this problem?  any ideas?  if there's any other debugging
information i can provide, just ask...  much thanks in advance!

-timothy


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/D7hwx+251UAEnQkRAl0UAKDGWA4A3Y084RDvhd7VNIeByp+qDACdGWgt
TRUhRQX/ck4JceS0TeHf1JU=
=2ef8
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
