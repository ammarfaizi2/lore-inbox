Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWGKObW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWGKObW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWGKObW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:31:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:2743 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750867AbWGKObV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:31:21 -0400
Message-Id: <200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org,
       rlrevell@joe-job.com, perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
In-Reply-To: Your message of "Tue, 11 Jul 2006 08:15:28 +0200."
             <20060711081528.4d3ab197.atlka@pg.gda.pl>
From: Valdis.Kletnieks@vt.edu
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl> <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl> <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
            <20060711081528.4d3ab197.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152628229_5755P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 10:30:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152628229_5755P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2006 08:15:28 +0200, Adam =3D?ISO-8859-2?B?VGxhs2th?=3D sa=
id:
> On Mon, 10 Jul 2006 22:09:51 -0400
> Valdis.Kletnieks=40vt.edu wrote:
>=20
> > On Tue, 11 Jul 2006 01:38:39 +0200, =3D?ISO-8859-2?Q?Adam_Tla=3DB3ka?=
=3D said:
> > > U=BFytkownik Lee Revell napisa=B3:
> > >
> > > > esd and artsd are no longer needed since ALSA began to enable sof=
tware
> > > > mixing by default in release 1.0.9.
> > >  >
> > >=20
> > > So why they are still exist in so many Linux distributions?
> >=20
> > As soon as somebody writes a patch to make the e16 window manager tal=
k ALSA
> > rather than use esd, I'm heaving esd over the side.
>=20
> Sorry to say but it is just not that way. Window manager is for managin=
g windows
> and it shouldn't depend on any audio system. It should use an external =
app using exec call
> to play sounds (aplay, sox, wavplay etc.) configured by some config opt=
ion.

So what you're saying is that something like 'esd' *is* needed.  (It's
certainly silly to keep doing fork/exec for every little sound sample whe=
n
you can just leave the app running and hand it requests...)

Either ALSA is up to the task, or it isn't and needs a front-end program
to babysit it. It doesn't matter if the program trying to play the sound
is a window manager, or an e-mail program, or something else....

--==_Exmh_1152628229_5755P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEs7YFcC3lWbTT17ARAmxiAJsEAjLcR4saPxKn94dsl9I9lL+d3wCfVn3W
1/Qj3S1t/6SivkkD0IBitRs=
=UgXy
-----END PGP SIGNATURE-----

--==_Exmh_1152628229_5755P--
