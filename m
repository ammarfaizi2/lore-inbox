Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272921AbTHKRm4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272915AbTHKRkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:40:31 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:58573
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S272875AbTHKRje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:39:34 -0400
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <2425882704.1060622541@aslan.btc.adaptec.com>
References: <1060543928.887.19.camel@blaze.homeip.net>
	 <2425882704.1060622541@aslan.btc.adaptec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dbGIbpTobs9p7O/A5Ox4"
Message-Id: <1060623576.2826.9.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Mon, 11 Aug 2003 13:39:36 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.7; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dbGIbpTobs9p7O/A5Ox4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-11 at 13:22, Justin T. Gibbs wrote:

> > On a side note, the same aic7xxx drivers version 6.2.8 and 6.2.36 works
> > with 2.4.21 and 2.4.22-rc1/rc2 series of kernel with above hardware.
>=20
> I don't think that any of the changes between 6.2.35 and 6.2.36 will
> make a difference for you, but you could try upgrading.  The source
> files are here:
>=20
> http://people.FreeBSD.org/~gibbs/linux/SRC/
>=20

Tried those already on both 2.4.21/22 and 2.6.0-test1,2,3.
While the 2.4 driver compiles and works fine the 2.5 sources does not
play nice with 2.6.0-test* kernel.I had to change the includes to blkdev
in the source and then there was few compile warnings.I can try to
provide the exact ones, unless there's a driver that applies to
2.6-test* cleanly.Once i had it compiled the kernel would just panic.

> The console output you've provided makes me think that interrupts are
> not working correctly in your system.
>=20

Is this due to my mainboard (nforce2),cpu,ACPI,devfs,sysfs...or all
these together?

I tried swapping the SCSI controller card in various PCI slots,used new
and original working cables,changed the BIOS IRQ's...etc

I start running of ideas here, is there other options to fully debug the
problem? What else can i try? I would appreciate any pointers.

I would like to get things working with 2.6.0 kernels...right now only
aic7xxx_old is somehow working but that's not the solution to the
problem.

> --
> Justin
>=20
>=20

Thank you for your time.

Paul



--=-dbGIbpTobs9p7O/A5Ox4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/N9TYIymMQsXoRDARAtZpAJ9AQWIpy0PqqRakKYIx11LWbEDepACfcgEk
4FziIJQo/BN6OGgCs0uYiQ0=
=R+EV
-----END PGP SIGNATURE-----

--=-dbGIbpTobs9p7O/A5Ox4--

