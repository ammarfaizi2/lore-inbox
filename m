Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292508AbSBYXit>; Mon, 25 Feb 2002 18:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSBYXig>; Mon, 25 Feb 2002 18:38:36 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:21695 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292508AbSBYXhY>; Mon, 25 Feb 2002 18:37:24 -0500
Date: Mon, 25 Feb 2002 18:37:17 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume and 3c59x
Message-ID: <20020225233717.GB5370@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020225200056.GW12719@ufies.org> <3C7A9C75.F6A4BA05@zip.com.au> <20020225162805.Q12832@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <20020225162805.Q12832@lynx.adilger.int>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2002 at 04:28:05PM -0700, Andreas Dilger wrote:
> On Feb 25, 2002  12:20 -0800, Andrew Morton wrote:
> > christophe barb=E9 wrote:
> Hmm, I have a similar problem with my Xircom 10/100 adapter (xirc2ps_cs).
> On resume it never works, so I eject/insert it each resume (via cardctl).
> My 3cce589et (10Mbps) card does not have this problem.
>=20
> In dmesg xirc2ps_cs reports:
> eth0: media 10Base2, silicon revision 4
>=20
> On a normal insertion it reports:
> eth0: MII link partner: 0081
> eth0: MII selected
> eth0: media 100BaseT, silicon revision 5
>=20
> I'm not sure if that is the real problem or just a symptom.  I'll have to
> look if it supports the enable_wol parameter...  Nope.  Any ideas?  2.4.17

My first Idea was to add a script in apm/event.d but I have a cardbus
managed by hotplug and it doesn't provide a way to do a soft eject as
you can do with cardctl.

Hoppefully my problem is solved with 2.4.18.

Christophe

>=20
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Dogs believe they are human. Cats believe they are God.

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8esqtj0UvHtcstB4RAiI7AJ0W5nbbNmecTrTLGozcSnTcCLnGUQCgljQB
jRc58E0MeEGMoEelkRwjCAQ=
=oIrA
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
