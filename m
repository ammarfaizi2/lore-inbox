Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264408AbUD0X31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264408AbUD0X31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUD0X31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:29:27 -0400
Received: from legolas.restena.lu ([158.64.1.34]:24453 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264408AbUD0X3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:29:14 -0400
Subject: Re: logitech mouseMan wheel doesn't work with 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <408EEA3E.6030803@bigfoot.com>
References: <40853060.2060508@bigfoot.com>
	 <200404202326.24409.kim@holviala.com> <408A16EB.30208@bigfoot.com>
	 <408EEA3E.6030803@bigfoot.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RfdGEEZExuW13WzVOwCO"
Message-Id: <1083108549.8203.12.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 28 Apr 2004 01:29:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RfdGEEZExuW13WzVOwCO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-28 at 01:18, Erik Steffl wrote:
> Erik Steffl wrote:
> > Kim Holviala wrote:
> >=20
> >> On Tuesday 20 April 2004 17:14, Erik Steffl wrote:
> >>
> >>
> >>>   it looks that after update to 2.6.5 kernel (debian source package b=
ut
> >>> I guess it would be the same with stock 2.6.5) the mouse wheel and si=
de
> >>> button on Logitech Cordless MouseMan Wheel mouse do not work.
> >>
> >>
> >>
> >> Try my patch for 2.6.5: http://lkml.org/lkml/2004/4/20/10
> >>
> >> Build psmouse into a module (for easier testing) and insert it with=20
> >> the proto parameter. I'd say "modprobe psmouse proto=3Dexps" works for=
=20
> >> you, but you might want to try imps and ps2pp too. The reason I wrote=20
> >> the patch in the first place was that a lot of PS/2 Logitech mice=20
> >> refused to work (and yes, exps works for me and others)....
> >=20
> >=20
> >   didn't help, I still see (without X running):
> >=20
> > 8, 0, 0 any button down
> > 9, 0, 0 left button up
> > 12, 0, 0 wheel up, sidebutton up
> > 10, 0, 0 right button up
> >=20
> > 8, 0, 0 wheel rotation (any direction)
> >=20
> > except of some protocols (IIRC ps2pp, bare, genps) ignore wheel=20
> > completely. is there any way to verify which protocol the mouse is=20
> > using? modprobe -v printed different messages for each protocol so I=20
> > think that worked (it said Generic Explorer etc.)
> >=20
> >   I tried: exps, imps, ps2pp, bare, genps
> >=20
> >   any ideas?
> >=20
> >   the mouse says: Cordless MouseMan Wheel (Logitech), it has left/right=
=20
> > buttonss, wheel that can be pushed or rotated and a side button, not=20
> > sure how to better identify it. With 2.4 kernels it used to work with X=
=20
> > using protocol MouseManPlusPS/2.
>=20
>    anybody? any hints? should I look at driver? are there some docs for=20
> logitech mice (protocol)?

err.. they all Just Work (tm) here.. ps2 or USB, IMPS/2 driver

Craig

--=-RfdGEEZExuW13WzVOwCO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAjuzFi+pIEYrr7mQRApcDAJ9ktEMDo0WOBzmPyNpontZ3JKWy+wCgm+2Q
3/gdgY7qDXdVqspXlzGsbLE=
=/8F2
-----END PGP SIGNATURE-----

--=-RfdGEEZExuW13WzVOwCO--

