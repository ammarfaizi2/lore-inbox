Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTHFQ4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTHFQ4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:56:22 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:5341
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S270654AbTHFQ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:56:10 -0400
Subject: Re: Badness in device_release at drivers/base/core.c:84
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: wb <dead_email@nospam.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3F2FD6ED.1005BB2C@yk.rim.or.jp>
References: <20030801182207.GA3759@blazebox.homeip.net>
	 <20030801144455.450d8e52.akpm@osdl.org>
	 <20030803015510.GB4696@blazebox.homeip.net>
	 <20030802190737.3c41d4d8.akpm@osdl.org>
	 <20030803214755.GA1010@blazebox.homeip.net>
	 <20030803145211.29eb5e7c.akpm@osdl.org>
	 <20030803222313.GA1090@blazebox.homeip.net>
	 <20030803223115.GA1132@blazebox.homeip.net>
	 <20030804093035.A24860@beaverton.ibm.com>
	 <1060021614.889.6.camel@blaze.homeip.net>
	 <1352160000.1060025773@aslan.btc.adaptec.com>
	 <5793.199.181.174.146.1060050091.squirrel@www.blazebox.homeip.net>
	 <3F2F84D2.8000202@nospam.com>  <3F2FD6ED.1005BB2C@yk.rim.or.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UI8KmLaumDnifGFywzx/"
Message-Id: <1060189107.887.7.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Wed, 06 Aug 2003 12:58:27 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.5; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UI8KmLaumDnifGFywzx/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-05 at 12:10, Ishikawa wrote:
> (Sorry this is not strictly related to SCSI, but I could not help it.)
>=20
> Regarding the use of a program from uucp suite
> for console output capture,
> we can use C-Kermit as well.
>=20
> >   Your need a NULL modem serial cable available
> >   from any computer store.
> >=20
> > Install uucp - I use on the HOST :
> >=20
> > uucp-1.06.1-33.7.2.
>=20
> Or you can use C-Kermit.
> See
>=20
>    http://www.columbia.edu/kermit/ckermit.html
>=20
> for details. There are precompiled packages.
>=20
> >  ... [omission ] ...
>=20
> > 5. Start uucp on the HOST:
> >=20
> >      cu -l /dev/ttyS0 -s 9600
>=20
>        kermit
>        set line /dev/ttyS0
>        set speed 9600
>        connect
> =20
> and you can issue other commands.
>         set [space] ?
> will print all the available options at that point.
> (You can log the interaction into a file by issueing
> a command to kermit, too, but using script and then run kermit
> inside the scripted session might be easier.)
> (Generally speaking hitting ? somewhere on the kermit command line
> prints usable options/setting/keywords, and so
> you can learn the basics very quickly.)
> You can set up a startup file that sets
> the device name, speed, parity, data size, etc. and
> so you don't have to type all the command every time.
>=20
> While I agree cu might work well for one shot job,
> running a full terminal emulator like C-Kermit
> helps us in the long term.
>=20
> Just thought to let you know a full-featured terminal
> emulator is available under linux.
>=20
> > John Donnelly AT HP DOT com
>=20
> Is the succinct and to the point steps
> part of a widely available document?
>=20
> I wish I knew this a few years ago.
>=20

Kermit was very helpful but due to my inexperience i was not able to get
the log due to Linux's box resetting of /dev/ttyS0 when booting, i would
get disconnect...

Thanks a lot for suggesting ckermit.

Regards,

Paul B.

--=-UI8KmLaumDnifGFywzx/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/MTOzIymMQsXoRDARAjQnAJ9c9la2CcB70InHqvPpmxa7lBv2mwCfe//v
vslfgeNVtfUstBVhgb310ss=
=qNTU
-----END PGP SIGNATURE-----

--=-UI8KmLaumDnifGFywzx/--

