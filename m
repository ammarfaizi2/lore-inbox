Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272476AbTGaNac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272478AbTGaNac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:30:32 -0400
Received: from [213.69.232.58] ([213.69.232.58]:39688 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S272476AbTGaNab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:30:31 -0400
Date: Thu, 31 Jul 2003 15:29:00 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: fun or real: proc interface for module handling?
Message-ID: <20030731132900.GU264@schottelius.org>
References: <20030731121248.GQ264@schottelius.org> <200307311713.24788.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O9T4zNOkGnr0n+A/"
Content-Disposition: inline
In-Reply-To: <200307311713.24788.yarick@relex.ru>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O9T4zNOkGnr0n+A/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yaroslav Rastrigin [Thu, Jul 31, 2003 at 05:13:24PM +0400]:
> > Hello!
> >
> > I was just joking around here, but what do you think about this idea:
> >
> > A proc interface for module handling:
> >    /proc/mods/
> >    /proc/mods/<module-name>/<link-to-the-modules-use-us>
> >
> > So we could try to load a module with
> >    mkdir /proc/mods/ipv6
> > and remove it and every module which uses us with
> >    rm -r /proc/mods/ipv6
> >
>=20
> Well, this idea itsel is quite neat, and could sometimes save lots of tim=
e=20
> (esp. when dealing with serious modules' deps). I would like to propose=
=20
> slightly different appropach:
> cp /lib/modules/2.6.0-test2/kernel/drivers/somedriver.ko /proc/modtree
> [...]

sounds nice, too.
With this idea the kernel would get the code directly, which is very nice.

Nico

--=20
echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--O9T4zNOkGnr0n+A/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/KRmctnlUggLJsX0RAqQlAJ4uBl9BH7B2j3FPa/DvnN44L/H/SQCeN11P
5bUJR3hr/+NKb8yQ8Sy0AXI=
=/iG5
-----END PGP SIGNATURE-----

--O9T4zNOkGnr0n+A/--
