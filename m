Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbTLFP6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTLFP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:58:19 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:37521
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265205AbTLFP6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:58:17 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Ian Kumlien <pomac@vapor.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com
In-Reply-To: <1070724815.13016.16.camel@athlonxp.bradney.info>
References: <1070676480.1989.15.camel@big.pomac.com>
	 <1070717770.13004.11.camel@athlonxp.bradney.info>
	 <1070721735.1991.20.camel@big.pomac.com>
	 <1070724815.13016.16.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ieiCGUVV1wIX8vtZ+D0k"
Message-Id: <1070726295.1995.40.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Dec 2003 16:58:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ieiCGUVV1wIX8vtZ+D0k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-06 at 16:33, Craig Bradney wrote:
> On Sat, 2003-12-06 at 15:42, Ian Kumlien wrote:
> Its a pity that as Bart said, those numbers dont reflect any sort of
> revision as that might lead to a conclusion about why it happens on some
> and not others.

Yeah i saw that aswell...=20

> > Btw, i have UDMA100 disks.. 2 disks on primary and 2 cdroms on
> > secondary... I dunno if this could make any difference..
>=20
> 1 ata133 primary master and dvdrw and cdrom on secondary here.

I'm just wondering if it could be a relation to the disk aswell or so..=20

> > Good luck =3D)
>=20
> You too :)

Heh, thanks =3D)

Now, about this ACPI powersave thing, wouldn't that be enabled in
windows aswell? So wouldn't this workaround be something that $other_os
doesn't have to do.

(In general i have always had to hack windows into not crashing when
linux worked and doing it the other way around without a real fix dosn't
sound that nice in my ears.. =3DP)

It would be interesting to hear from nvidia about nmi_watchdog... Since
nmi_watchdog with the 'not-done-correctly' APIC patch claims that nmi is
stalled/locked/doesn't work... If nvidia states that this *should* work,
then we have something to go on.

Also, if Allen Martin (nvidia) could go trough the proc/interrupts and
tell us if something is wrong, like the XT-PIC on timer. Or just give us
a correct listing, since noone had io-apic-edge on timer before afair.=20

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-ieiCGUVV1wIX8vtZ+D0k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0fyX7F3Euyc51N8RAkxuAKCq/d6hq02IcxqXfNLn3M2Uzerk/ACfQool
efTup6zDB5WpTT0/aFJGetQ=
=ma/H
-----END PGP SIGNATURE-----

--=-ieiCGUVV1wIX8vtZ+D0k--

