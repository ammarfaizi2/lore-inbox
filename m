Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUAPPwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAPPwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:52:02 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:35983 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265354AbUAPPv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:51:58 -0500
Subject: Re: modprobe failed: digest_null
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040113150319.1e309dcb.rddunlap@osdl.org>
References: <20040113215355.GA3882@piper.madduck.net>
	 <20040113143053.1c44b97d.rddunlap@osdl.org>
	 <20040113223739.GA6268@piper.madduck.net>
	 <20040113144141.1d695c3d.rddunlap@osdl.org>
	 <20040113225047.GA6891@piper.madduck.net>
	 <20040113150319.1e309dcb.rddunlap@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jxY5ZvHbO7vNNL7nTmsd"
Message-Id: <1074268509.23742.744.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 17:55:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jxY5ZvHbO7vNNL7nTmsd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-01-14 at 01:03, Randy.Dunlap wrote:
> On Tue, 13 Jan 2004 23:50:47 +0100 martin f krafft <madduck@madduck.net> =
wrote:
>=20
> | also sprach Randy.Dunlap <rddunlap@osdl.org> [2004.01.13.2341 +0100]:
> | > I would guess that you have a high-priority $PATH to old modprobe
> | > than to the new modprobe...
> |=20
> | That would surprise me, Debian handles this quite well:
> |=20
> | diamond:~# which modprobe
> | /sbin/modprobe
> | diamond:~# modprobe -V
> | module-init-tools version 3.0-pre5
> | diamond:~# modprobe.modutils -V
> | modprobe version 2.4.26
> | modprobe: QM_MODULES: Function not implemented
> | diamond:~# uname -r
> | 2.6.1
>=20
> OK, maybe someone else has an answer then.
>=20
> The message:
> kernel: request_module: failed /sbin/modprobe -- digest_null. error =3D 2=
56
> is from modutils and not from module-init-tools according to my
> source files.
>=20

Its from the kernel afaik.  It calls modprobe, fails, and then prints
its own custom message.  He basically just have something that tries
to load a module with alias 'digest_null', but there is no such module,
so fails.

I have the same thing when I open gnome-mixer:

--
request_module: failed /sbin/modprobe -- sound-slot-1. error =3D 256
--

as I only have one sound card ...


Cheers,

--=20
Martin Schlemmer

--=-jxY5ZvHbO7vNNL7nTmsd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBACAldqburzKaJYLYRAhIzAJ9XDh7ilfNdn23k4zqJufE1Ur1pKwCfQ1wJ
xpIjiDiVId4nHXtBdV+1Xyo=
=lFiJ
-----END PGP SIGNATURE-----

--=-jxY5ZvHbO7vNNL7nTmsd--

