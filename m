Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272824AbTHEOXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272826AbTHEOXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:23:11 -0400
Received: from [24.241.190.29] ([24.241.190.29]:17556 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S272824AbTHEOXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:23:06 -0400
Date: Tue, 5 Aug 2003 10:22:59 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
Message-ID: <20030805142259.GP13456@rdlg.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030805122354.GL13456@rdlg.net> <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com> <20030805135046.GO13456@rdlg.net> <Pine.LNX.4.53.0308051003070.7244@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tk6xM/wkRlnXD2NA"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308051003070.7244@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tk6xM/wkRlnXD2NA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



It is production.  This week these systems go to 2.4.21-ac4 with the
2.8.0 i2c.  I only think it's not a straight up kernel bug because there
are 35ish identicle systems running all the same software with 0
problems.  In addition for some odd reason this one machine was giving
some very odd temp readings.


Thus spake Zwane Mwaikambo (zwane@arm.linux.org.uk):

> On Tue, 5 Aug 2003, Robert L. Harris wrote:
>=20
> > Code:  Bad EIP value.
> >=20
> > >>EIP; 8011c560 Before first symbol   <=3D=3D=3D=3D=3D
> > Trace; c011c47d <tasklet_hi_action+5d/90>
> > Trace; c011c1ff <do_softirq+6f/d0>
> > Trace; c0108bdb <do_IRQ+db/f0>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c010ae78 <call_do_IRQ+5/d>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c0105400 <default_idle+0/40>
> > Trace; c010542c <default_idle+2c/40>
> > Trace; c01054a2 <cpu_idle+42/60>
> > Trace; c0117e7f <release_console_sem+8f/a0>
> > Trace; c0117d8e <printk+11e/140>
> >=20
> >  <0>Kernel panic: Aiee, killing interrupt handler!
>=20
> It looks like someone freed a tasklet without removing it. But considerin=
g=20
> your kernel cocktail (imported i2c code) it makes it harder for us to=20
> debug, perhaps if you could try on a newer kernel (i know it'd be hard to=
=20
> do if it's production)
>=20
> --=20
> function.linuxpower.ca

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--tk6xM/wkRlnXD2NA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/L73D8+1vMONE2jsRAmMgAJ9x+gf/kyHHDQMahz9744nvQBoHGwCePkby
rkBotxmp38fjIS9ujSLep7k=
=Q8ef
-----END PGP SIGNATURE-----

--tk6xM/wkRlnXD2NA--
