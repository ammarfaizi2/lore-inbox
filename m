Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbTKDKnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 05:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTKDKnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 05:43:42 -0500
Received: from D7098.d.pppool.de ([80.184.112.152]:24748 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264064AbTKDKnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 05:43:39 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Daniel Egger <degger@fhm.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1067896476.692.36.camel@gaston>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-imeg7k9NIdxBE4EHqP+B"
Message-Id: <1067941579.16778.5.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 11:43:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-imeg7k9NIdxBE4EHqP+B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, den 03.11.2003 schrieb Benjamin Herrenschmidt um 22:54:

> It works with up to date stuffs. That is my latest 2.6 tree with
> radeonfb and XFree from CVS. Part of the problem is that the firmware
> sets up a tiled display. I updated my radeonfb to "clear" the
> various SURFACE_* translation registers (among other fixes).

I've the most recent X but up to now I've tried your 2.4 branch where
radeonfb doesn't work, so I was using offb.

> Yup. I need to figure that out. It's possible that it does like a G5,
> that is boot full speed when you auto-boot and low speed when you boot
> via OF user interface. There may be need for some thermal control as
> well.

This would be so cool.

> The "N" thing is normal. Apple hacked so that only DHCP servers which
> know about some special Apple extensions can be used when doing that.

I believe for this there are patches floating aroung which teach the ISC
DHCPd new parameters. There are also config snipplets which let one
configure using decimal notation of the attributes; will try.

> The easy work around is to use the syntax:
> enet:x.x.x.x,file

Yupp, this is what I'm doing...

--=20
Servus,
       Daniel

--=-imeg7k9NIdxBE4EHqP+B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/p37Lchlzsq9KoIYRAne9AJ9ZfweXjtNJM+UUokY2K8ocGmudkgCg5DDj
xlb3iO/UyCYFmsTLQCCL2i0=
=srQw
-----END PGP SIGNATURE-----

--=-imeg7k9NIdxBE4EHqP+B--

