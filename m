Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTGOHCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTGOHCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:02:09 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:27666 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265422AbTGOHCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:02:06 -0400
Date: Tue, 15 Jul 2003 00:16:55 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: e1000 with 82546EB parts on 2.4?
Message-ID: <20030715001654.D25443@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm working with some hardware that may or may not be completely reliable,
and trying to figure out if something I'm seeing is a 'known issue' or
something strange about my setup (which is entirely possible).

I'm using 2.4.20 with some custom hardware.

What I've got is your basic x86 machine with an Intel 82546EB dual-GigE
controller on a PCI bus.  I load e1000.o, ifconfig, and I'm running.  The
interface is solid as a rock, AFAICT.  I've left it running for days
without any problems.

However, if I ifdown and then ifup the interface, I'm borked.  Based on
tcpdump from another machine, the interface is definately transmitting
packets just fine.  But, it never seems to notice any packets on the
receive side.

Has anyone seen anything like this before?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A:  The most ironic oxymoron wins ...
DP: "Microsoft Works"
A:  Uh, okay, you win.
					-- A.J. & Dust Puppy
User Friendly, 1/18/1998

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/E6pmIjReC7bSPZARAn6BAKCc6d1mZymkf4Ujxo59dmBdxQEMawCffeC5
O34eQ7q8/shHeCucdRDQ04M=
=uj3n
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
