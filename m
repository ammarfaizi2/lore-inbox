Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWDOT1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWDOT1P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDOT1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:27:15 -0400
Received: from crystal.sipsolutions.net ([213.151.39.204]:37255 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751268AbWDOT1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:27:14 -0400
Subject: Re: Current linus git bcm4xxx broken for me
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: bcm43xx-dev@lists.berlios.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1144974919.4686.1.camel@localhost.localdomain>
References: <1144972957.5006.2.camel@localhost.localdomain>
	 <1144974919.4686.1.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PTTBAr0PjL+Bv+BTriaa"
Date: Sat, 15 Apr 2006 21:27:11 +0200
Message-Id: <1145129231.6560.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PTTBAr0PjL+Bv+BTriaa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-14 at 10:35 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-04-14 at 10:02 +1000, Benjamin Herrenschmidt wrote:
> > I get that with current upstream git :
>=20
>   .../...
>=20
> Correction: It actually works after tickling softmac a bit (it's an open
> network with non advertised essid, the init scripts are supposedly
> setting the essid but softmac is having some vapors, changing the essid
> manually a couple of times and it ends up associating).

Below ...

> Still, the dmesg filling up with those messages is pretty nasty :)

There are two issues here. One is the messages (related to it being a
0x4318) and secondly that softmac isn't behaving will :)
I'm trying to fix the latter but can't really pinpoint the problem yet.

johannes

--=-PTTBAr0PjL+Bv+BTriaa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAREFJDqVg1VMiehFYAQJmgg//Wu6p9abDs2avpHDFyzo0r/yADuTAn7+k
aQfQJJMqlKp12GZT5BtxvEZMAD32cs+mhk965wKNj2UxhV8Ph1pizRZMFVrsd/mL
Z205Zot5EpBUDUSz1anUVQuvUS70CUBgyDfeCvfI/KepS9M2uXFWCcKj4/t0z68E
PionX7I4A0OK3H26D3piEMdYJSkMAFm+15GAhfxmoOOFtCItVLggG4IkQbYGokE6
92izew9qdFYATSOmp5T75rDM0CHtgwUEHGws8bEKqdZoqBZTU4uAHloYj9hgX685
WlNhkGAaHW1Wzd+k6BuXLHBTdQ0BKAPAzg2KSEX4vzif6Z5b6doeax31gO1v2lGm
hjk7W58SvsVh5+kqrIT/lEWv8SGYIojL+33SnoWNQ+uM7QGgrm0QmvmzpQTySIID
4RIRhHMV7+do9bURbxJI7A+rqIfMNFInwHdPlDw+VoAzFQ2BLMHu4VjflGfhy5Z0
l897UfIvFw6rgE2Whc+C99ROj+9jCpw1Aj2ztdPLVoHB3w5AXKFCzuXN3m1KYGUX
3RU81XqtnCbZIPIoiqypn5hzuVkEJ+JNHOrvGUUBv25uQTdFkb7/paaIFHZLSmxe
2vsLqf5aQvf3gdbA+ywdqBdX8lBBnXIbeInwM6XFwMvGRZ0ZZoje81yABqz/FuRK
pLRm918ycVE=
=RvQc
-----END PGP SIGNATURE-----

--=-PTTBAr0PjL+Bv+BTriaa--

