Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSFWRDa>; Sun, 23 Jun 2002 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSFWRD3>; Sun, 23 Jun 2002 13:03:29 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53514 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S317063AbSFWRD3>;
	Sun, 23 Jun 2002 13:03:29 -0400
Date: Sun, 23 Jun 2002 19:03:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020623170330.GZ24903@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020602.203916.21926462.davem@redhat.com> <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-06-04 08:50:11 -0700, Patrick Mochel <mochel@osdl.org>
wrote in message <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net=
>:
> On Sun, 2 Jun 2002, David S. Miller wrote:
> >    From: Anton Blanchard <anton@samba.org>
> >    Date: Mon, 3 Jun 2002 14:27:27 +1000

[Order of grouped init calls]

> early_arch
> mem
> subsys
> arch
> fs
> device
> late

Just a dumb ass question: We're currently dealing with grouped init
calls. Why don't we simply give them numbers like we do in
/etc/rc<X>.d/S<YZ>startme.sh? That would possibly give an easier
mechanism of keeping all those init calls in a sane order!?

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Ff9hHb1edYOZ4bsRAqsJAJ0axRgyg7XG9AoUXtVl6TV73gF6zQCffY6F
+hyPgokKAZlTK7xwUNs7AYo=
=bIX5
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--
