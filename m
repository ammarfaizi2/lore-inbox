Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFJGkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTFJGkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:40:09 -0400
Received: from [61.95.53.28] ([61.95.53.28]:18182 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S262413AbTFJGkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:40:04 -0400
Date: Tue, 10 Jun 2003 16:53:36 +1000
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030610065336.GA25833@himi.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <20030610061654.GB25390@himi.org> <20030610064829.GA2370@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20030610064829.GA2370@kroah.com>
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2003 at 11:48:29PM -0700, Greg KH wrote:
> On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> > I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> > p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> > kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> > tested is bk as of 2003-06-04). lspci lists this hardware:
>=20
> Hm, mine boots, but my kernel locks up when accessing /dev/rtc in the
> init scripts (through hwclock.)  2.5.69 works, 2.5.70 doesn't.  I
> haven't spent the time to search out the offending problem yet...
>=20
Apparently there's some kind of problem with ACPI and the rtc driver
- leaving out /dev/rtc support got it up and running quite happily,
until this framebuffer oops came along.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5YBvQPlfmRRKmRwRAiHDAJ9VqY/psxTlZwXTNdPdqnUo4d3USQCcCadl
6r5y/KlW8tUq5Mo9Nxrmx10=
=MGZc
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
