Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268496AbTBWPRL>; Sun, 23 Feb 2003 10:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268491AbTBWPPP>; Sun, 23 Feb 2003 10:15:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:60660 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268490AbTBWPOl>;
	Sun, 23 Feb 2003 10:14:41 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030223153316.262a201e.skraw@ithnet.com>
References: <20030202153009$2e0d@gated-at.bofh.it>
	 <20030205181006$107c@gated-at.bofh.it>
	 <20030205181006$7bb8@gated-at.bofh.it>
	 <20030205181006$455c@gated-at.bofh.it>
	 <20030205181006$5dba@gated-at.bofh.it>
	 <20030205181006$3358@gated-at.bofh.it>
	 <200302061451.h16Epl0Z001134@pc.skynet.be>
	 <20030223153316.262a201e.skraw@ithnet.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xIUTfJQ0boLCSZTU2r+E"
Organization: 
Message-Id: <1046012671.1964.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 23 Feb 2003 16:04:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xIUTfJQ0boLCSZTU2r+E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-02-23 at 15:33, Stephan von Krawczynski wrote:
> On Thu, 06 Feb 2003 15:51:47 +0100
> Hans Lambrechts <hans.lambrechts@skynet.be> wrote:
>=20
> > Stephan von Krawczynski wrote:
> >=20
> > <---snip--->
> >=20
> > >=20
> > >            CPU0       CPU1
> > >   0:      71158          0    IO-APIC-edge  timer
> > >   1:        941          0    IO-APIC-edge  keyboard
> > >   2:          0          0          XT-PIC  cascade
> > >  12:      33166          0    IO-APIC-edge  PS/2 Mouse
> > >  15:          4          0    IO-APIC-edge  ide1

<snip>

> I am sorry, but this patch is:
> a) already included in 2.4.21-pre4 (which I run)
> b) does therefore obviously not help
>=20
> Any other suggestions?=20

could you give the irqbalance daemon from

http://people.redhat.com/arjanv/irqbalance/irqbalance-0.06.tar.gz

a try ?

Greetings,
   Arjan van de Ven

--=-xIUTfJQ0boLCSZTU2r+E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+WOL/xULwo51rQBIRAkrLAKCpWVAi0BHMAuoP6fFHApUl3znC8gCfdyqx
QWoaXL5DifVImKvpM7BXIE8=
=5fdY
-----END PGP SIGNATURE-----

--=-xIUTfJQ0boLCSZTU2r+E--
