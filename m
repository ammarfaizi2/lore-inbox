Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbTLISMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbTLISMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:12:19 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:47280
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265994AbTLISMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:12:17 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org, recbo@nishanet.com
In-Reply-To: <200312081207.45297.ross@datscreative.com.au>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bUevnAcnTAc23X4Gf6dZ"
Message-Id: <1070993538.1674.10.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 19:12:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bUevnAcnTAc23X4Gf6dZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Bob wrote:
> Using a patch that fixes a number of people's nforce2
> lockups while enabling io-apic edge timer, I can now
> use nmi_watchdog=3D2 but not =3D1

Why regurgitate patches that are outdated, Personally i find int
outdated after Ross made his patches available and they DO enable
nmi_watchdog=3D1. (I have seen the old patches mentioned more than once,
if something better comes along, please move to that instead.)

http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107080280512734&w=3D2

Anyways, Is there anyway to detect if the cpu is "disconnected" or, is
there anyway to see when the kernel sends it's halts that triggers the
disconnect? (or is it automagic?)

If there was a way to check, then thats all thats needed, all delays can
be removed and the code can be more generalized.

(Since doubt that this is apic torment. It's more apic trying to talk to
a disconnected cpu... (which both approaches hints at imho))

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-bUevnAcnTAc23X4Gf6dZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/1hCC7F3Euyc51N8RAmPHAKCdN0QduFhsAeJkfrzixhWzydeRZACfXo1k
B/djESOuSIsjDOP4zVhmqmw=
=SEMY
-----END PGP SIGNATURE-----

--=-bUevnAcnTAc23X4Gf6dZ--

