Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSATRJR>; Sun, 20 Jan 2002 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSATRJI>; Sun, 20 Jan 2002 12:09:08 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:38571 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S288828AbSATRIy>; Sun, 20 Jan 2002 12:08:54 -0500
Date: Sun, 20 Jan 2002 12:08:37 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Guus Sliepen <guus@warande3094.warande.uu.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe@ufies.org>
Subject: Re: usb-ohci, ov511, video4linux
Message-ID: <20020120170837.GD2873@online.fr>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	lkml <linux-kernel@vger.kernel.org>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe@ufies.org>
In-Reply-To: <20020120154119.GB2873@online.fr> <20020120162258.GC16166@sliepen.warande.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20020120162258.GC16166@sliepen.warande.net>
User-Agent: Mutt/1.3.25i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 20, 2002 at 05:22:58PM +0100, Guus Sliepen wrote:
> On Sun, Jan 20, 2002 at 10:41:19AM -0500, christophe barb=E9 wrote:
>=20
> > The Xawtv outputs are interesting :
> >=20
> > # xawtv
> > This is xawtv-3.68, running on Linux/i586 (2.4.17)
> > /dev/video0 [v4l]: no overlay support
>=20
> That's normal.
>=20
> > v4l-conf had some trouble, trying to continue anyway
>=20
> That too, because of the earlier warning about overlay.
>=20
> > v4l: timeout (got SIGALRM), hardware/driver problems?
> > ioctl: VIDIOCSYNC(0): Appel syst=E8me interrompu
> > v4l: timeout (got SIGALRM), hardware/driver problems?
> > ioctl: VIDIOCSYNC(1): Appel syst=E8me interrompu
>=20
> xawtv has a very short timeout when it tries to grab frames. It really
> was made for TV cards, not webcams. You can either change xawtv's
> libng/grab-v4l.c and edit the line containing #define SYNC_TIMEOUT, or
> use a program like gqcam that is written especially for slow USB
> webcams.
>=20
> The problems with the other USB devices might be caused by the fact that
> USB webcams will use all the available bandwidth.

I have the same problem with gqcam, camstream and gnomemeeting.
With xawtv and the debug option, the problem disapears. Perhaps the
timeout is increased in this case. I will check the code.

The problem with the usb mouse is there with or without webcam.

Christophe

>=20
> --=20
> Met vriendelijke groet / with kind regards,
>   Guus Sliepen <guus@sliepen.warande.net>



--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs come when they're called;
cats take a message and get back to you later. --Mary Bly

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8SvmVj0UvHtcstB4RAgrVAJ44TpYU4tC2QBys1DpAwNZL6g2DIACfS34u
xp2V/YuWjHRUF/hJDywxu3c=
=XsV1
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
