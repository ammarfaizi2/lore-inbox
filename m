Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132627AbRDOLjR>; Sun, 15 Apr 2001 07:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132629AbRDOLi6>; Sun, 15 Apr 2001 07:38:58 -0400
Received: from cdsl18.ptld.uswest.net ([209.180.170.18]:47208 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S132627AbRDOLi4>;
	Sun, 15 Apr 2001 07:38:56 -0400
Date: Sun, 15 Apr 2001 04:38:37 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: nicholas@petreley.com, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci.c problems in latest kernels?
Message-ID: <20010415043836.C15118@debian.org>
In-Reply-To: <20010414213546.A1590@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010414213546.A1590@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sat, Apr 14, 2001 at 09:35:46PM -0400
X-Operating-System: Linux galen 2.4.3-ac4+lm+bttv
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2001 at 09:35:46PM -0400, Pete Zaitcev wrote:
> > usb-uhci.c: interrupt, status 3, frame# 1876=20
>=20
> This is a known problem, here is the discussion that I initiated
> on linux-usb-devel:
>=20
>  http://marc.theaimsgroup.com/?t=3D98609508500001&w=3D2&r=3D1
>=20
> The right fix is to comment that printout out.
> In fact, that is what I commited for Red Hat 7.1 release.

I'm not sure of that.  Sometimes keys get "stuck" in the down position
with my USB keyboard (mechanical switches, so the keys themselves are not
sticking) and usually when that happens I can find a line like the one
quoted above in the logs.  Also, occasionally my mouse goes black (one of
the optical Logitech's) with a similar line and must be disconnected and
reconnected to work again.  Again, similar line in the logs.

Nothing fatal happens.  Pressing another key fixes the keyboard and my old
fashioned USB ball mouse ;) works fine.


> Some people suggest to switch to uhci instead of usb-uhci,
> which helps precisely because it does not have a corresponding
> printk.

I've seen similar suggestions for people with AMD-based systems.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

Change the Social Contract?  BWAHAHAHAHAHAHAHAHAHAHAHA.
	-- Branden Robinson


--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrZiDwACgkQj/fXo9z52rNX3wCgq8p1OuftDLIkB9toFOLSt0S3
cQUAnRMGsG3/Fo9qaU8L5tQQY6BGaNot
=Hvic
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
