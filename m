Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267426AbUBROd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUBROd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:33:58 -0500
Received: from [199.45.143.209] ([199.45.143.209]:58634 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S267426AbUBROd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:33:56 -0500
Subject: Re: TCP: Treason uncloaked DoS ??
From: Zan Lynx <zlynx@acm.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Klaus Ethgen <Klaus@Ethgen.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040218105508.GA7320@dingdong.cryptoapps.com>
References: <20040218102725.GB3394@hathi.ethgen.de>
	 <20040218105508.GA7320@dingdong.cryptoapps.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VQzZd72WBXlcWShzrmJ2"
Message-Id: <1077114772.7182.4.camel@titania.zlynx.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 07:32:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VQzZd72WBXlcWShzrmJ2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-18 at 03:55, Chris Wedgwood wrote:
> On Wed, Feb 18, 2004 at 11:27:25AM +0100, Klaus Ethgen wrote:
>=20
> > Well I have the same every night when my backup on the local host is
> > running. Many of the "kernel: TCP: Treason uncloaked! Peer
> > 192.168.17.2:2988/33016 shrinks window 3035402428:3035418812. Repaired.=
"
>=20
> > But 192.168.17.2 is the same host! So the buggy TCP stack seams to
> > be in linux kernel.
>=20
> My guess is there is a PacketShaper in between mangling things.

I have seen this same Treason uncloaked! error message between two of my
Linux systems recently, while running rsync backups between them.  One
system is 2.4.21, the other 2.6.2.  I was not using any shaping.

I was trying to figure it out, but I cannot reproduce it reliably, it
seems to just happen.
--=20
Zan Lynx <zlynx@acm.org>

--=-VQzZd72WBXlcWShzrmJ2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAM3eUG8fHaOLTWwgRAtTZAJ92k4Wg3foMySSobbcE80P5XM0FtgCaA4eL
rM6XlObgCMjvq5yscXkEzSg=
=BeMc
-----END PGP SIGNATURE-----

--=-VQzZd72WBXlcWShzrmJ2--

