Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290662AbSBOTUZ>; Fri, 15 Feb 2002 14:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290666AbSBOTUH>; Fri, 15 Feb 2002 14:20:07 -0500
Received: from [208.151.48.2] ([208.151.48.2]:10702 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S290662AbSBOTUC>; Fri, 15 Feb 2002 14:20:02 -0500
Subject: Re: funny console prob w/2.4.18-pre[479]+kpreempt+sched-o(1)
From: "Samuel M. Stringham" <sams@e-sa.com>
To: Jorge Nerin <comandante@zaralinux.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C6D34B5.3050900@zaralinux.com>
In-Reply-To: <3C66743C.9BA03219@folkwang-hochschule.de> 
	<3C6D34B5.3050900@zaralinux.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-U2EbvEHUOsU7Un4P9EUY"
X-Mailer: Evolution/1.0.2 (1.0.2-1) 
Date: 15 Feb 2002 14:07:47 -0500
Message-Id: <1013800067.6448.11.camel@linux-admin.esa-hq.e-sa.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U2EbvEHUOsU7Un4P9EUY
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable


On Fri, 2002-02-15 at 11:17, Jorge Nerin wrote:
> J=F6rn Nettingsmeier wrote:
> > hello *
> >=20
> > it happens to me regularly that the x server dies without any
> > obvious reason.
>=20
> I remeber that some time ago, around XFree 4.0 I also had this issues.
>=20
> > funny thing is, it takes the virtual text consoles with it, which is
> > why i'm posting here.
> >=20
>=20
> Yes, the same issues, now it almost never dies, and if it dies the=20
> consoles work ok (I'm using FB at 1024x768 and Xfree at 1152x864)
>=20
hmm... I had the same problem as the original poster with 4.0, not with
4.1 and rawhides 4.2 XFree86 packages won't even let me start up with
dri+OpenGL (different problem).  I will try to rebuild X from source
tonight see if I can garner some insight.
> > i end up in kdm and i can restart x alright, but when i switch vc's,
> > all i see is a frozen image of the x screen. i can switch back to x,
> > and it runs.
> >=20
>=20
> When this happened to me I saw garbage from the X screen from the time=20
> it died, let's see, X dies, I get dropped to the console (seeing garbage=20
> colors of the scren) gdm restarts, everything seems ok, but going back=20
> to the console you see the same garbage as before.
>=20
yes, I get/got this too, hasn't happened recently, but then again X
hasn't crashed recently.  Another thing (I believe was fbdev related)
was the screwing up of the fonts (! missing the dot at the bottom,
etc.).  I believe that was fixed circa 2.4.17/2.5.2 .
> > all tasks i started on the vc's before keep running, the mingettys
> > are there, the bashes are there, and i can even blind-type commands
> > that will run correctly. only the display is messed up.
> > a blind-typed "reset" has no effect.
> >=20
>=20
> I also found that enebling the xv extension in my XFree causes the=20
> consoles to be lost, but in a different way.
>=20
> After enabling it and entering X if I switch to a console I see the=20
> console image, but no matter what I do the console stays the same, as=20
> you say I can type blindly.
>=20
> > any clues ?
> > i'm using x version 4.2.0 with a voodoo3 card (dri and agp enabled).
> > this is an smp box with 2 p3/600 katmai.
> > might this be not a kernel issue, but an x11 problem ?
> >=20
>=20
> We have too many things in common to stablish a pattern, I'm using XFree=20
> 4.2.0, a voodoo 3 2000 pci card, and I also have a smp box, but it's a=20
> 2x200mmx.
>=20
> I think it's a X issue by not leaving the console state consitent.
>=20
yes, same as above, this is a rather coincidental about the HW configs.
I have a dual celeron (famous bp6 config) with vodoo3 with dri and agp
enabled.
> > best wishes,
> >=20
> > j=F6rn
> >=20
> >=20
> > please keep be cc:ed, i only read lkml archives.
> >=20
>=20
> I'm doing
>=20
>=20
> --=20
> Jorge Nerin
> <comandante@zaralinux.com>
>=20
> -

Samuel Stringham
Network Administrator
www.e-sa.com

--=-U2EbvEHUOsU7Un4P9EUY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8bVyDAHsuhBrdlT0RAo91AJ9Ot744XwSYv6WJT83bkH/lQzUKqgCfZedZ
oveJEQ2qZ+Dmr4f87pdOKUE=
=Bs/6
-----END PGP SIGNATURE-----

--=-U2EbvEHUOsU7Un4P9EUY--
