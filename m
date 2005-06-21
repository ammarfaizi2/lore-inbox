Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFUL0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFUL0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFULZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:25:26 -0400
Received: from mx.laposte.net ([80.245.62.11]:15290 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261187AbVFULLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:11:02 -0400
Subject: Re: Tuner module is too verbose
From: "Damien \"tuX\" THEBAULT" <damien.thebault@laposte.net>
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
In-Reply-To: <42B7AFAF.7000402@brturbo.com.br>
References: <1119289192.22634.24.camel@tux.rezid.org>
	 <42B7AFAF.7000402@brturbo.com.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KPhsLUreZlh+u8UOAi+z"
Date: Tue, 21 Jun 2005 13:10:23 +0200
Message-Id: <1119352223.12112.17.camel@tux.rezid.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KPhsLUreZlh+u8UOAi+z
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le mardi 21 juin 2005 =E0 03:11 -0300, Mauro Carvalho Chehab a =E9crit :
>=20
>     Maybe there's a radio application that is competing with your TV app.

>     Your patch will help aliviating the verbose problem, but maybe you
> should check if every radio apps are turned off before calling video
> app, since they share the same resources.
>=20
> Mauro Chehab.

I don't use any radio app.
Sometimes nxtvepg, but that was not the case.
I tried with only one program (xawtv alone, checked with lsof), the
result is the better than with my usual tv app (tvtime) : the messages
only occurs when starting and selecting channels.

For example :

<xawtv start>
[ 3989.965116] tuner 2-0060: Cmd VIDIOCSCHAN accepted to TV
[ 3989.969098] tuner 2-0060: Cmd VIDIOCSCHAN accepted to TV
[ 3989.971804] tuner 2-0060: Cmd VIDIOCSCHAN accepted to TV
[ 3989.974269] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3989.974347] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3989.974420] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3989.974494] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3989.974565] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3990.098003] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3990.099445] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3990.099763] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3990.139961] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3990.140481] tuner 2-0060: Cmd VIDIOCSFREQ accepted to TV
[ 3990.166434] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
<channel change>
[ 3995.931665] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 3995.932022] tuner 2-0060: Cmd VIDIOCSFREQ accepted to TV
[ 3995.960413] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
<xawtv stop>
[ 4000.957714] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio
[ 4002.838733] tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio

--=20
Damien Thebault
public keys on http://pgp.mit.edu

--=-KPhsLUreZlh+u8UOAi+z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBCt/WfVHEaRMFauK8RAvVpAJ9il2V2AOQifKKapoimPBCVhzt2YACYx1I/
6SP04ubT7gPiYL7wOYQKeQ==
=u50g
-----END PGP SIGNATURE-----

--=-KPhsLUreZlh+u8UOAi+z--

