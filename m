Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269973AbTGLIJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 04:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269982AbTGLIJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 04:09:00 -0400
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.181.13]:640 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S269973AbTGLII6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 04:08:58 -0400
Date: Sat, 12 Jul 2003 04:14:04 -0400
From: timothy parkinson <t@timothyparkinson.com>
To: linux-kernel@vger.kernel.org
Subject: Re: netgear f312 (natsemi) under 2.5.75
Message-ID: <20030712081404.GA3126@timothyparkinson.com>
References: <20030712072744.GA225@timothyparkinson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20030712072744.GA225@timothyparkinson.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


apologies for replying to myself...

the solution to this problem (for me) was to boot the kernel with "noapic" =
on
the command line.  (note to self, always pay attention to email from dave
jones :-)

if anyone could point me to more info on this bug i'd be appreciative (an
lkml thread that i missed the first time around maybe?)  thanks anyway!

-timothy


On Sat, Jul 12, 2003 at 03:27:44AM -0400, timothy parkinson wrote:
>=20
> hi,
>=20
> thought i'd give 2.5.75 a try today, and the only thing that i couldn't g=
et
> to work is my network card:
>=20
> 00:08.0 Ethernet controller: National Semiconductor Corporation DP83815
> (MacPhyter) Ethernet Controller
>         Subsystem: Netgear: Unknown device f312
>=20
> i'm working on a reasonably close to default slackware 9.0 box, with a wo=
rking
> 2.4.21 kernel of my own build.
>=20
> i started out by installing module-init-tools-0.9.12, and then built 2.5.=
75.
> the module (natsemi.o) seems to load just fine with no complaints.  dhcpcd
> runs, the lights flash on my cable modem, things appear to be working just
> the same as 2.4.21, however dhcpcd just exits silently without bringing up
> eth0.
>=20
> i've tried building the driver into the kernel instead, recompiling dhcpc=
d,
> resetting the cable modem - it works under 2.4.21 just fine, the only
> variable is the kernel.  i'm completely at a loss here.
>=20
> anyone else seeing this problem?  any ideas?  if there's any other debugg=
ing
> information i can provide, just ask...  much thanks in advance!
>=20
> -timothy
>=20



--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/D8NMx+251UAEnQkRAnSiAKChA7Xrbak+1KLH6Rz5PBvMw8DKhQCeNA0v
SxsvyK2hKqpqyorCqmdcfIQ=
=WQpp
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
