Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRKHVq7>; Thu, 8 Nov 2001 16:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRKHVqu>; Thu, 8 Nov 2001 16:46:50 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:8607 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S278592AbRKHVql>;
	Thu, 8 Nov 2001 16:46:41 -0500
Date: Thu, 8 Nov 2001 22:45:58 +0100
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@online.fr>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support
Message-ID: <20011108224558.C505@online.fr>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108203718.B505@online.fr> <200111082006.fA8K6BY63324@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <200111082006.fA8K6BY63324@aslan.scsiguy.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: "debian SID Gnu/Linux 2.4.14 on i586"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2001 at 01:06:11PM -0700, Justin T. Gibbs wrote:
> >> I also wonder why the reset delay is 15000 Msec. It used to be 5000
> >> Msec. I've usually set it to that without nasty results. I just wonder
> >> what the reasoning is behind such a long delay.
> >
> >This is a drawback of single driver for multiple cards. Good cards
> >suffer to enable the driver to support bad ones.
>=20
> This has nothing to do with the card the aic7xxx driver is accessing.

Sorry if I upset you. My point was not to criticize your driver, I'm a
happy aic7xxx user.

I've used your drivers with three cards, all recent, and for each the
timeout seems oversized. I was convinced it was to support old hardware.
You seems to indicate that it depends more on the attached scsi targets,
and I believe it but I have never seen this kind of configuration where
the timeout needs to be 15000 Msec. Is this a so common config to set
this value as default ?

Christophe

>=20
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE76v0Wj0UvHtcstB4RAihBAJ9PP3e1dwCvmEDsiLK6BlvTQTOM5wCfbsGw
mQgCcURJeCMGFXoP6d5ZDvk=
=qfSF
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
