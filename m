Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272732AbTG1IEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272733AbTG1IEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:04:46 -0400
Received: from [213.69.232.58] ([213.69.232.58]:37384 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S272732AbTG1IEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:04:43 -0400
Date: Mon, 28 Jul 2003 10:18:33 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: psmouse: synaptics (2.6.0-test1|2)
Message-ID: <20030728081832.GA453@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

My touchpad stops working with 2.5.74.

With 2.6.0test2 I got minimal success:
If I attach an external ps2mouse while booting, I can use this one.
Until I remove it, soon the kernel (psmouse I think) tries to init
the touchpad which fails.

My questions:
   1) why are you implementing drivers in the kernel?
   2) what source of information do you use to program them?
   3) how can I read /dev/misc/psaux in Linux 2.6 ?
   3.1) howto get gpm running?
   3.2) is the patch mentioned for X implemented in X cvs?


Nico

--=20
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/JNxYtnlUggLJsX0RAoIwAJ40U/f0GXoeP6YsiEpCIXrlCS9IZwCfUrRh
7tsTvN/JzOS7lL+OmnT78C0=
=TikW
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
