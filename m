Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272993AbTGaMOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272997AbTGaMOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 08:14:21 -0400
Received: from [213.69.232.58] ([213.69.232.58]:56840 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S272993AbTGaMOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 08:14:19 -0400
Date: Thu, 31 Jul 2003 14:12:48 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: scholz@wdt.de
Subject: fun or real: proc interface for module handling?
Message-ID: <20030731121248.GQ264@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fu8LepSeDvpxVgv6"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fu8LepSeDvpxVgv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I was just joking around here, but what do you think about this idea:

A proc interface for module handling:
   /proc/mods/
   /proc/mods/<module-name>/<link-to-the-modules-use-us>

So we could try to load a module with
   mkdir /proc/mods/ipv6
and remove it and every module which uses us with
   rm -r /proc/mods/ipv6

Modul options could be passed my
   echo "psmouse_noext=3D1" > /proc/mods/psmouse/options
which would also make it possible to change module options while running..

It's just an idea, perhaps someone likes this..
perhaps if there is enough feedback I even could think about
implementing it.


Greetings'

Nico

ps: please CC, the majordomo isn't answering my subscribe requests..

--=20
echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--fu8LepSeDvpxVgv6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/KQfAtnlUggLJsX0RApp4AJ4rgPSXi1wdxpfQACiyTEKBzXg/jwCfRiz3
qhT7kLVQR3E0AVwMfmqdS0U=
=C6eT
-----END PGP SIGNATURE-----

--fu8LepSeDvpxVgv6--
