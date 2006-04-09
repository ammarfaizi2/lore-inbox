Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWDITWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWDITWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWDITWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:22:16 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:16022 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750774AbWDITWQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:22:16 -0400
Subject: Re: [OOPS] related to swap?
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux-kernel@vger.kernel.org
In-Reply-To: <44339031.4040307@yahoo.com.au>
References: <1144225363.7112.10.camel@localhost>
	 <44339031.4040307@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AZ7pfOZ6coK0cNDrfO0c"
Date: Sun, 09 Apr 2006 21:31:58 +0200
Message-Id: <1144611118.7535.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AZ7pfOZ6coK0cNDrfO0c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-05 at 19:38 +1000, Nick Piggin wrote:
> Ian Kumlien wrote:
> > As i said, i really doubt that the memory is at fault here, it has done
> > several passes over the memory but not all tests. I can give it a go
> > though, but i really doubt it'll find anything.
>=20
> If it doesn't cost you much time (ie. do it overnight) it could save some
> developers a lot of time.

Well, the memory passes test 1-5 and 8. The 32 bit thingies all fail on
4 dimms, so either 4 dimms are broken or the test is broken for amd64.

Anyways, i noticed that the memory clocking got skewed when all the
memory was in the machine, so i've removed 1gb of memory.

> > The kernel i run is a plain 2.6.16.1 from kernel.org (i have heard that
> > you can actually compile gentoos own these days)
>=20
> OK, good.

2.6.16.2 now... And a new nvidia driver...

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-AZ7pfOZ6coK0cNDrfO0c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQBEOWEu7F3Euyc51N8RAjJIAKCRgab3zW8+hJy2BZZUnXJFGxAzyACfZ3lO
CWe2T6G4airxRhol8t0BQbk=
=xsDI
-----END PGP SIGNATURE-----

--=-AZ7pfOZ6coK0cNDrfO0c--

