Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUGBPad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUGBPad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUGBPac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:30:32 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:20461 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S262882AbUGBPaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:30:30 -0400
Date: Fri, 2 Jul 2004 17:30:28 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: linux-kernel@vger.kernel.org
Subject: Strange Network behaviour
Message-ID: <20040702153028.GD15170@ostc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-226-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
following Situation:

4 Servers=20
involved Hardware:
  - Motherboard: MSI MS-6728=20
  - Onboard Gigabit NetworkInterface: Intel 82562EZ (e1000)
  - 100 MBit NetworkInterface: D-Link DFE-530TX (via-rhine)

Connected through a 1GB-Switch and a 100MBit-Switch. The second
connects about 40 X-Terminals too.

On all Servers is a SuSE Linux 9.0 professional installed; online
updates every night.  When they start up, everything is fine. After
some hours when i want to do a tcpdump on one of the Interfaces i get:

'tcpdump: socket: Address family not supported by protocol' =20

ethereal doesn't find any interface.

Sometimes some of the 100MBit-IFs didn't answer anymore. The only
cure was to reboot. Neither rcnetwork restart nore unloading the
network-module did help.

This happend for a long time until there was a kernel patch from
2.4.21-215 to 2.4.21-266. Since it is installed this error doesn't
appear anymore.

On my home-system with a sis900 NW-IF the same happend once. But
there too is kernel 2.4.21-266 now.

Does someone has have made the same experience or does someone has
an idea what was the reason.

Thanks for any ideas in advance

Greetings
Hermann

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFA5X+TOtrQgwstjuoRAmUWAJ9/l6Vjs8tCHDAOR84k9njURbmKnwCgycJK
xDE4TuEpV3PVOM2y2vlKLAA=
=XYUq
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
