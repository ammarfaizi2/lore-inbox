Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUFVORy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUFVORy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUFVORc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:17:32 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:32764 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264088AbUFVOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:16:48 -0400
Subject: Re: [netdev watchdog/b44] is something broken? (problem somewhat
	found)
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RL5w2mVxZlZfaOAroHS5"
Message-Id: <1087913806.2971.155.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 16:16:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RL5w2mVxZlZfaOAroHS5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,=20

I just did a new observation, this only seems to happen with udp
packets...=20

Ie, i'm now transferring with ftp instead of nfs and it doesn't die.
if a udp packet is delayed and not sent, shouldn't it just be dropped?
I mean instead of restarting the network card?

Esp when it can kill a alta card after a while (ie reboot =3D=3D only optio=
n
since it just refuses to go online again.)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net=09

--=-RL5w2mVxZlZfaOAroHS5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2D9O7F3Euyc51N8RAqCpAJwJKHvzqros+2rSD4QT11D8YUmR4QCfeQaf
Zurznaebr95M7typ79LnJ5A=
=1oxe
-----END PGP SIGNATURE-----

--=-RL5w2mVxZlZfaOAroHS5--

