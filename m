Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUAERRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUAERR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:17:29 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:25217 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265205AbUAERRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:17:21 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Willy Tarreau <willy@w.ods.org>,
       szonyi calin <caszonyi@yahoo.com>, Con Kolivas <kernel@kolivas.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <1073294318.3247.80.camel@localhost>
References: <1073227359.6075.284.camel@nosferatu.lan>
	 <20040104225827.39142.qmail@web40613.mail.yahoo.com>
	 <20040104233312.GA649@alpha.home.local>
	 <20040104234703.GY1882@matchmail.com>  <1073294318.3247.80.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/PJKlqgwBWEFuCuK700m"
Message-Id: <1073323208.6075.318.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 19:20:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/PJKlqgwBWEFuCuK700m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 11:18, Soeren Sonnenburg wrote:
> On Mon, 2004-01-05 at 00:47, Mike Fedyk wrote:
> > On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> > > at a time. I have yet to understand why 'ls|cat' behaves
> > > differently, but fortunately it works and it has already saved
> > > me some useful time.
> >=20
> > cat probably does some buffering for you, and sends the output to xterm=
 in
> > larger blocks.
>=20
> yes indeed, judging from the cat source it does chose optimal buffer
> size, here 1024 byte... so it reads/writes larger chunks... and jump
> scrolling takes place...
>=20

I cannot reboot right now, so have wrong kernel for testing, but could
anyone see what happens if you start X reniced to +10 or such?  Maybe
some other numbers?


--=20
Martin Schlemmer

--=-/PJKlqgwBWEFuCuK700m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+ZzIqburzKaJYLYRAlblAJ0SlXDbyiUfMAQc64rpy6EmteOq4wCfZBXp
UeV/oHMoxjp899rcrsxgdvc=
=D+0o
-----END PGP SIGNATURE-----

--=-/PJKlqgwBWEFuCuK700m--

