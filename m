Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUBHL1G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUBHL1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:27:06 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:910 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263462AbUBHL1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:27:02 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1075868708.11322.23.camel@nosferatu.lan>
References: <20040203201359.GB19476@kroah.com>
	 <1075843712.7473.60.camel@nosferatu.lan>
	 <1075849413.11322.6.camel@nosferatu.lan> <20040203231341.GA22058@kroah.com>
	 <1075868708.11322.23.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i5dTjtHxKqUzx9vaJxeg"
Message-Id: <1076239649.6996.58.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 08 Feb 2004 13:27:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i5dTjtHxKqUzx9vaJxeg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-04 at 06:25, Martin Schlemmer wrote:

> > > 2) events gets missing.  If you for example use udevsend in the
> > > initscript that populate /dev (/udev), the amount of nodes/links
> > > created is off with about 10-50 (once about 250) entries.
> >=20
> > Hm, that's not good.  I'll go test that and see what's happening.
> >=20
>=20
> Script is attached.  If I was being silly here, let me know.  Some
> quick testing again, it seems like the missing events is more with
> the echo not commented, but could be just some fluke (there was
> still however more than 5 usually missing).
>=20

Btw, I also get this now and then for /dev/snd/* stuff.  I had a few
times already where controlC0 was not created (and this is after the
script runs to generate /dev ...).


Thanks,

--=20
Martin Schlemmer

--=-i5dTjtHxKqUzx9vaJxeg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAJh0hqburzKaJYLYRAmV9AJoDviLE+HgsIG5xs2xaw9AhvSkjGACghxSO
WaNCY9usPxEn3UHkhrMEzOY=
=lxAs
-----END PGP SIGNATURE-----

--=-i5dTjtHxKqUzx9vaJxeg--

