Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUAEV0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAEV0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:26:37 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:41345 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265303AbUAEV0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:26:32 -0500
Subject: Re: File system cache corruption in 2.6?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Jens Axboe <axboe@suse.de>
Cc: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040105121905.GB3124@suse.de>
References: <Pine.LNX.4.58-035.0401050014450.5565@unix49.andrew.cmu.edu>
	 <20040105121905.GB3124@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9G3u5wUWO6KKVdNWHssd"
Message-Id: <1073338159.6075.339.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 23:29:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9G3u5wUWO6KKVdNWHssd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 14:19, Jens Axboe wrote:
> On Mon, Jan 05 2004, Nathaniel W. Filardo wrote:
> > Hi all,
> > 	I'm trying to work out the cause of a series of issues I've seen
> > on my 2.6 machine.  It appears as though files (specifically libraries)=
 in
> > memory can get corrupted, resulting in strangeness like segfaults and
> > things like "relocation error: can't find symbol ...-VOMD-POINTER" inst=
ead
> > of "...-VOID-POINTER".
>=20
> That's a single bit error.
>=20
> > I don't believe it's actual hardware failure for a few reasons: memtest=
86
> > passes all tests, GCC doesn't crash (it's a Gentoo system, so gcc and I
> > are well acquainted - and before I get jumped on, I've installed udev ;=
)
> > ), and most importantly, sometimes thrashing the file system or engagin=
g a
> > kernel compile will rectify the situation, as just happened with emacs.
> > It crashed, I killed it, it wouldn't load - I started a kernel compile,
> > waited a bit, and lo', it works again.  No messages of relevance appear=
 in
> > dmesg.
>=20
> It looks _extremely_ much like bad memory, or bad hardware. Sometimes
> memtest just doesn't catch all errors (how long did you run it? needs
> several days often).

Also, go to the options, and turn on caching, as well as all memory
addresses and tests ... (keys pressed if I can remember, is:

  c->1->2->2->3->3->3

should turn on above options for memtest).


--=20
Martin Schlemmer

--=-9G3u5wUWO6KKVdNWHssd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+dcvqburzKaJYLYRAqvHAJ47UzBn0uEL7laarh1guRv8BmgR2QCfQ6r2
EP8l11Sw+3xoU8S3d7xWyFI=
=dBfO
-----END PGP SIGNATURE-----

--=-9G3u5wUWO6KKVdNWHssd--

