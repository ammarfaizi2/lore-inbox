Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUATS2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbUATS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:28:09 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:19963 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265661AbUATS2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:28:00 -0500
Date: Wed, 21 Jan 2004 07:30:46 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Help port swsusp to ppc.
In-reply-to: <1074599060.793.11.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074623445.2016.10.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-yMZqhuR1lOtsQXuvSJfj";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040119105237.62a43f65@localhost>
 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
 <1074555531.10595.89.camel@gaston>
 <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
 <20040120100405.GB183@elf.ucw.cz> <1074598014.739.7.camel@gaston>
 <20040120113630.GA380@elf.ucw.cz> <1074599060.793.11.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yMZqhuR1lOtsQXuvSJfj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm really interested to see how you are going to initiate and execute
the suspend.

Perhaps I'm just ignorant, but I can't see how you can do it without
resorting to the same tricks we use now with regards to CPU context. I
think you're going to find yourself reinventing the wheel.

Regards,

Nigel

> I plan to run everything provided by the suspended kernel actually. My id=
ea
> is to keep a handle to a page of the suspended kernel that contains that
> code and just kick into it. Copying pages to their final location without
> overriding the source pages is a bit of a funky job, but I had to do it
> already with BootX so ... I'll work on that during one of the upcoming fe=
w
> weeks hopefully, I'm a bit swamped with 3 different things at the moment.
>=20
> ben.
> =20
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-yMZqhuR1lOtsQXuvSJfj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADXPVVfpQGcyBBWkRAkPOAJ9gYxPhv1FsS5if/TkIRkoV0Ab7lgCeOJpw
zSFpzb4Ajwxij0UBJWs6akk=
=E0uS
-----END PGP SIGNATURE-----

--=-yMZqhuR1lOtsQXuvSJfj--

