Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUD1HNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUD1HNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUD1HNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:13:31 -0400
Received: from legolas.restena.lu ([158.64.1.34]:23272 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264672AbUD1HNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:13:18 -0400
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <408EF33F.5040104@bigfoot.com>
References: <40853060.2060508@bigfoot.com>
	 <200404202326.24409.kim@holviala.com> <408A16EB.30208@bigfoot.com>
	 <408EEA3E.6030803@bigfoot.com>
	 <1083108549.8203.12.camel@amilo.bradney.info>
	 <408EF33F.5040104@bigfoot.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-USgLTSJBVv2AfiJmUJii"
Message-Id: <1083136394.23415.4.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 28 Apr 2004 09:13:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-USgLTSJBVv2AfiJmUJii
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-28 at 01:56, Erik Steffl wrote:
> Craig Bradney wrote:
> > On Wed, 2004-04-28 at 01:18, Erik Steffl wrote:
> >=20
> >>Erik Steffl wrote:
> >>
> >>>Kim Holviala wrote:
> >>>
> >>>
> >>>>On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
> >>>>
> >>>>
> >>>>
> >>>>>  it looks that after update to 2.6.5 kernel (debian source package =
but
> >>>>>I guess it would be the same with stock 2.6.5) the mouse wheel and s=
ide
> >>>>>button on Logitech Cordless MouseMan Wheel mouse do not work.
> >>>>
> >>>>
> >>>>
> >>>>Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10
> >>>>
> >>>>Build psmouse into a module (for easier testing) and insert it with=20
> >>>>the proto parameter. I'd say "modprobe psmouse proto=3Dexps" works fo=
r=20
> >>>>you, but you might want to try imps and ps2pp too. The reason I wrote=
=20
> >>>>the patch in the first place was that a lot of PS/2 Logitech mice=20
> >>>>refused to work (and yes, exps works for me and others)....
> >>>
> >>>
> >>>  didn't help, I still see (without X running):
> >>>
> >>>8, 0, 0 any button down
> >>>9, 0, 0 left button up
> >>>12, 0, 0 wheel up, sidebutton up
> >>>10, 0, 0 right button up
> >>>
> >>>8, 0, 0 wheel rotation (any direction)
> >>>
> >>>except of some protocols (IIRC ps2pp, bare, genps) ignore wheel=20
> >>>completely. is there any way to verify which protocol the mouse is=20
> >>>using? modprobe -v printed different messages for each protocol so I=20
> >>>think that worked (it said Generic Explorer etc.)
> >>>
> >>>  I tried: exps, imps, ps2pp, bare, genps
> >>>
> >>>  any ideas?
> >>>
> >>>  the mouse says: Cordless MouseMan Wheel (Logitech), it has left/righ=
t=20
> >>>buttonss, wheel that can be pushed or rotated and a side button, not=20
> >>>sure how to better identify it. With 2.4 kernels it used to work with =
X=20
> >>>using protocol MouseManPlusPS/2.
> >>
> >>   anybody? any hints? should I look at driver? are there some docs for=
=20
> >>logitech mice (protocol)?
> >=20
> >=20
> > err.. they all Just Work (tm) here.. ps2 or USB, IMPS/2 driver
>=20
>    which kernel (mine doesn't work with 2.6.5, used to work with 2.4.x),=20
> which mouse models? I guess there might be more models and for some=20
> reason my particular model does not work. Can you find out which=20
> protocol the kernel is using (psmouse, not usb)?

2.4.x, 2.61,3,5, currently 2.6.5 on 4 PCs

-logitech cordless optical for notebooks (USB)
-logitech cordless mouseman optical (via a kmv switch to 2PCs )(ps2)
-logitech cordless optical mouse(ps2)

err. how do i find out the protocol the kernel uses?

Craig

--=-USgLTSJBVv2AfiJmUJii
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAj1mJi+pIEYrr7mQRAktKAKCJxff/INa0JTCTBHpj8pmRG401wQCfZNDI
O/BgJVNbihFsbeYWekJaSdQ=
=8esj
-----END PGP SIGNATURE-----

--=-USgLTSJBVv2AfiJmUJii--

