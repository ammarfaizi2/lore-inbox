Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbTLFOmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbTLFOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:42:21 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:33169
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265175AbTLFOmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:42:17 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070717770.13004.11.camel@athlonxp.bradney.info>
References: <1070676480.1989.15.camel@big.pomac.com>
	 <1070717770.13004.11.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CDuUCLesZYWADrIrPSUR"
Message-Id: <1070721735.1991.20.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 15:42:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CDuUCLesZYWADrIrPSUR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-06 at 14:36, Craig Bradney wrote:
> On Sat, 2003-12-06 at 03:08, Ian Kumlien wrote:=20
> > You could always move eth0 to a different slot. Other than that, you ca=
n
> > do manual config for the irq's in the bios, but it shouldn't be
> > needed...
>=20
> eth0 is the 3com onboard on the a7n8x deluxe...=20

I find that so odd... My on board network controller is a realtec phys
controlled by a nvidia mac. Same goes for audio.

> Having finally woken up (me not the pc), uptime here is now 12 hours..
> (without the CPU Disconnect athcool run, just the kernel patch). I did
> run the athcool program to check the result though:
>=20
> nVIDIA nForce2 (10de 01e0) found
> 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

nVIDIA nForce2 (10de 01e0) found
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.


> Perhaps my motherboard and cpu doesnt have a problem with disconnect and
> just the IRQ issue, perhaps because its only a few weeks old. It would
> make sense in some ways given that my system has only one of the
> problems given the uptime I have been able to reach.

Mine is 2 weeks old or so..=20

> My hangs have always been when I have used the PC.. and often completed
> a task and then a few seconds later it goes.

Mine always seems to hang after a certain amount of time... When id
didn't do a grep in the kernel lib.

Btw, i have UDMA100 disks.. 2 disks on primary and 2 cdroms on
secondary... I dunno if this could make any difference..

> Will see in time I guess

Good luck =3D)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-CDuUCLesZYWADrIrPSUR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0erH7F3Euyc51N8RAgl9AJ9NWaQ72nbW3jDN1BIdG+RUFyXnSQCfRnUs
S7p7RzIuBl4dmEcQAOlUNdI=
=mrd7
-----END PGP SIGNATURE-----

--=-CDuUCLesZYWADrIrPSUR--

