Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWBEP1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWBEP1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWBEP1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:27:53 -0500
Received: from smtp04.auna.com ([62.81.186.14]:30459 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S1751763AbWBEP1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:27:52 -0500
Date: Sun, 5 Feb 2006 16:32:54 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060205163254.6fcebf79@werewolf.auna.net>
In-Reply-To: <43E4B2C3.3040109@rtr.ca>
References: <20060110132957.GA28666@elte.hu>
	<20060110133728.GB3389@suse.de>
	<Pine.LNX.4.63.0601100840400.9511@winds.org>
	<20060110143931.GM3389@suse.de>
	<Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	<43C3E9C2.1000309@rtr.ca>
	<20060110173217.GU3389@suse.de>
	<43C3F0CA.10205@rtr.ca>
	<43C403BA.1050106@pobox.com>
	<43C40803.2000106@rtr.ca>
	<20060201222314.GA26081@MAIL.13thfloor.at>
	<uhd7irpi7@a1i15.kph.uni-mainz.de>
	<Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr>
	<43E3DB99.9020604@rtr.ca>
	<Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr>
	<43E4B2C3.3040109@rtr.ca>
X-Mailer: Sylpheed-Claws 2.0.0cvs9 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_PZ6+42yK1z6fa4LysrqWnRX;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Sun, 5 Feb 2006 16:27:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_PZ6+42yK1z6fa4LysrqWnRX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 04 Feb 2006 08:57:23 -0500, Mark Lord <lkml@rtr.ca> wrote:

> Jan Engelhardt wrote:
> >
> > What userspace programs do depend on it?
>=20
> That *is* the question, isn't it.
> We simply don't know, other than that this is
> a visible change to any program that cares.
>=20
> Gratuitis breakage of userspace is pointless.
>=20
> Empirically speaking, everything I use is working fine
> here with the 2G/2G split, but that's just not good enough
> reason to mindlessly break other people's userspace.
>=20

The only thing I have seen that depends explicitely on this setting
is valgrind, but I think that CVS included some kind of runtime
configuration/selection.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam8 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_PZ6+42yK1z6fa4LysrqWnRX
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD5hqmRlIHNEGnKMMRAjyCAKCcLQglcwTvQgibhOo9eoikGMTC3ACgiRup
3aPfDJ6KqGT/I9AUknl2nSA=
=Krgt
-----END PGP SIGNATURE-----

--Sig_PZ6+42yK1z6fa4LysrqWnRX--
