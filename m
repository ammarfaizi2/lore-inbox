Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273054AbRIOVE6>; Sat, 15 Sep 2001 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273057AbRIOVEk>; Sat, 15 Sep 2001 17:04:40 -0400
Received: from mail.direcpc.com ([198.77.116.30]:26560 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S273054AbRIOVEg>; Sat, 15 Sep 2001 17:04:36 -0400
Subject: Re: Random Sig'11 in XF864 with kernel > 2.2.x
From: Jeffrey Ingber <jhingber@ix.netcom.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1000555291.6970.10.camel@DESK-2>
In-Reply-To: <1000530589.2267.11.camel@DESK-2> 
	<3BA32C51.B4D9B14@t-online.de>  <1000555291.6970.10.camel@DESK-2>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Wl3SDLikgjA/i7Qfvf4q"
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.20.39 (Preview Release)
Date: 15 Sep 2001 17:09:09 -0400
Message-Id: <1000588153.7474.3.camel@DESK-2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wl3SDLikgjA/i7Qfvf4q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks for your feedback!

Just to make some clarifications:

The random Sig 11's are observed in the stock XFree86 4.x drivers with
none of the 'extras' enabled, such as DRI on several sets of video cards
(Matrox and ATI).  I can run both UP and SMP kernels in the 2.2 series
and 2.4 UP kernels with unlimited uptimes.  However, switching to a 2.4
SMP kernel will cause random Sig 11's in X, seemingly irregardless of
video card/vendor.=20

The systems are all stock hardware as well as the distros (excluding
errata).  It's difficult to ascertain information on this problem due to
the 'randomness' of the crashes.  I don't have to do anything unusual to
cause this crash:  Just install a recent distro on an SMP machine, stare
at the screen, and X will eventually crash.

I'm not totally convinced that this is a kernel problem, but it seems
that only a handful of people seem to be aware of this.  (This has been
going on for well over a year, around the time of the mid-2.3 kernels).=20
The fact that a 2.4 kernel seems to be catalyst lends some creedence to
this theory.

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)


>=20
> On Sat, 2001-09-15 at 06:24, Frank Schneider wrote:
> > Jeffrey Ingber schrieb:
> > >=20
> > > Hello kernel developers:
> > >=20
> > > I'm experiencing random Signal 11's on kernels in the 2.4 series with
> > > XFree86 4 and SMP configurations.  Here a some threads to the XFree86
> > > mailing lists which suggest that the Signal 11's are kernel related.
> > > Downgrading to a 2.2 series kernel solves these problems:
> > >=20
> > > http://www.xfree86.org/pipermail/xpert/2001-September/011053.html
> > > http://www.xfree86.org/pipermail/xpert/2001-September/011229.html
> > >=20
> > > Here's a snippet from my posting to the list:
> > >=20
> > > ----
> > > > Dell PowerEdge 6300 (Quad Xeon 500) with ATI Rage 128
> > > > IBM Netfinity 5600 (Dual PIII 667) with Matrox MMS Quad Monitor
> > > > Tyan Tunderbolt S1873UANG-R (Dual PIII 600) with Matrox Marvel G400
> > >=20
> > >    I'll bet it goes away if you don't use a 2.4 SMP kernel.
> > > That is, use a 2.4 UP kernel or a 2.2 UP/SMP kernel.
> > > ---
> > >=20
> > > And this turned out to be the case.  Is there anything that I could d=
o
> > > help fix this?  Is there anyone else on this list that has had simila=
r
> > > problems and has overcome this?
> > >=20
> >=20
> > Hello..
> >=20
> > I can only admit that i also know this problem.
> >=20
> > I run a RH7.1 on a dual-PIII/850 with a Matrox G400/16MB, and i also ha=
d
> > several crashes of X, mostly when Netscape runs, but some without it.
> >=20
> > What i did:
> > I changed the default colourdepth from 24 to 16 and i got the "original=
"
> > mga.o-modules from www.matrox.com.
> >=20
> > But this did not help, i suffered a crash some days ago again, but this
> > time i had a logentry, it said:
> >=20
> > ---------
> > Sep 12 13:14:27 falcon kernel: [drm] Process 850 dead (ctx 1, d_s =3D
> > 0x00)
> > ---------
> >=20
> > I run XFree 4.0.3 and have enabled the Matrox-Options in the Kernel
> > under "Character devices - Support for Matrox g200/g400", but this did
> > not help either.
> >=20
> > Another problem i got by using the modules from "matrox.com", i cannot
> > switch between consoles and X anymore, if i switch back to X several
> > times (one time usually is ok), the whole machine crashes, i have to
> > reboot via SysRq and even that does not work everytime. But this is
> > related to the "mga.o"-module from matrox, i hadnt this effect with the
> > mga.o from XFree86.
> >=20
> > Solong..
> > Frank.
> >=20
> > --
> > Frank Schneider, <SPATZ1@T-ONLINE.DE>.                          =20
> > Microsoft isn't the answer.
> > Microsoft is the question, and the answer is NO.
> > ... -.-
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20


--=-Wl3SDLikgjA/i7Qfvf4q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7o8N1aMTzuMuv5OERAukkAJ9leRz3Lx5bJiter1Ugp1vGuco4NgCfQLZX
pYgYbHPN404GlgjcBJPygGI=
=zqF8
-----END PGP SIGNATURE-----

--=-Wl3SDLikgjA/i7Qfvf4q--

