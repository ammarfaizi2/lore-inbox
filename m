Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSGCSmI>; Wed, 3 Jul 2002 14:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSGCSmI>; Wed, 3 Jul 2002 14:42:08 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:27145 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S317182AbSGCSmH>; Wed, 3 Jul 2002 14:42:07 -0400
From: glynis@butterfly.hjsoft.com
Date: Wed, 3 Jul 2002 14:44:30 -0400
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: linux 2.5.24-dj2 acpi on dell inspiron 3800
Message-ID: <20020703184430.GA16210@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

observations about my configuration:
1.  i tried writing states 1-3 to /proc/acpi/sleep, and that seems to
work as expected, putting it to sleep.  when it wakes, the screen
won't come back, i don't think sysrq keys work, and i end up holding
the power button to get it to shutdown.

2.  swsusp works, and wakes properly the first time.  it leaves the
clock out of sync, the ps2 mouse doesn't work until reload of the
psmouse module, but the software-ejected pcmcia nic actually
automatically reinserts itself.  i can deal with scripting up these
things, but i'd be interested in good ways to hook the wake event.

on the second swsusp suspend/wake, bash oopses the kernel immediately
upon waking.  updated will oops a few minutes afterward.

this all shows alot of promise, but i'd like to know how to clear
these things up.  i've been anxiously awaiting a new kernel to see if
it's cleaned up.

thanks.

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9I0YOCGPRljI8080RAqwZAJ9wPcd9VtcGNluEAsefwn4UOVIRkgCfVy+2
9YsM2DHPy2yO6o+/lOT7Tr4=
=IGXQ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
