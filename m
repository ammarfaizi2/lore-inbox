Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264689AbUD1Igk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbUD1Igk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 04:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUD1Igk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 04:36:40 -0400
Received: from legolas.restena.lu ([158.64.1.34]:44451 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264689AbUD1Igh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 04:36:37 -0400
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <408F697D.2010906@bigfoot.com>
References: <40853060.2060508@bigfoot.com> <408EF33F.5040104@bigfoot.com>
	 <1083136394.23415.4.camel@amilo.bradney.info>
	 <200404281022.23878.kim@holviala.com>  <408F697D.2010906@bigfoot.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I/t9iNrNT1hPqa0MF0L0"
Message-Id: <1083141393.24381.9.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 28 Apr 2004 10:36:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I/t9iNrNT1hPqa0MF0L0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-28 at 10:21, Erik Steffl wrote:
> Kim Holviala wrote:
> > On Wednesday 28 April 2004 10:13, Craig Bradney wrote:
> >=20
> >=20
> >>>>>> the mouse says: Cordless MouseMan Wheel (Logitech), it has
> >>>>>>left/right buttonss, wheel that can be pushed or rotated and a side
> >>>>>>button, not sure how to better identify it. With 2.4 kernels it use=
d
> >>>>>>to work with X using protocol MouseManPlusPS/2.
> >>>>>
> >>>>>  anybody? any hints? should I look at driver? are there some docs f=
or
> >>>>>logitech mice (protocol)?
> >>>>
> >>>>err.. they all Just Work (tm) here.. ps2 or USB, IMPS/2 driver
> >>>
> >>>   which kernel (mine doesn't work with 2.6.5, used to work with 2.4.x=
),
> >>>which mouse models? I guess there might be more models and for some
> >>>reason my particular model does not work. Can you find out which
> >>>protocol the kernel is using (psmouse, not usb)?
> >>
> >>2.4.x, 2.61,3,5, currently 2.6.5 on 4 PCs
> >>
> >>-logitech cordless optical for notebooks (USB)
> >>-logitech cordless mouseman optical (via a kmv switch to 2PCs )(ps2)
> >>-logitech cordless optical mouse(ps2)
> >>
> >>err. how do i find out the protocol the kernel uses?
> >=20
> >=20
> > Check your kernel logs (/var/log/messages perhaps). Grepping for "psmou=
se"=20
> > will help you find the relevant part.
>=20
>    didn't find anything for psmouse but found these in dmesg output=20
> after doing modprobe psmouse with difeferent protocols (you can see I=20
> was trying different protocols, none of them worked (turning wheel=20
> doesn't work, sidebutton is same as middle button):
>=20
> input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
> input: PS2++ Logitech Mouse on isa0060/serio1
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> input: PS2++ Logitech Mouse on isa0060/serio1
> input: PS/2 Generic Mouse on isa0060/serio1
> input: PS/2 Generic Mouse on isa0060/serio1
> input: ExPS/2 Generic Explorer Mouse on isa0060/serio1
>=20
> 	erik
> -
laptop:
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
desktop:
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serial

Note.. I dont use modules in the kernel if possible...=20

Craig



--=-I/t9iNrNT1hPqa0MF0L0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAj20Ri+pIEYrr7mQRAlnFAJ4zghefea7j4yzm0VNfT5pM1sr+cQCeLCrN
sBT5dZ68ns8dqP/6wi2kP70=
=r6mO
-----END PGP SIGNATURE-----

--=-I/t9iNrNT1hPqa0MF0L0--

