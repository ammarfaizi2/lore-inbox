Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWB1Hs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWB1Hs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 02:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWB1Hs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 02:48:58 -0500
Received: from lugor.de ([212.112.242.222]:52402 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751914AbWB1Hs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 02:48:57 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Tue, 28 Feb 2006 08:47:45 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <200602272348.37288.mail@earthworm.de> <200602281040.44957.ncunningham@cyclades.com>
In-Reply-To: <200602281040.44957.ncunningham@cyclades.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6720020.FOX7EZvp2u";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602280847.51677.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Tue, 28 Feb 2006 08:47:53 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart6720020.FOX7EZvp2u
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 28 February 2006 01:40, Nigel Cunningham wrote:
> On Tuesday 28 February 2006 08:48, Hesse, Christian wrote:
> > On Wednesday 22 February 2006 21:12, Hesse, Christian wrote:
> > > On Wednesday 22 February 2006 11:10, Hesse, Christian wrote:
> > > > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > > > Hello everybody,
> > > > > > > >
> > > > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in
> > > > > > > > status D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc=
3.
> > > > > > > > Any hints what could be the problem? It worked perfectly wi=
th
> > > > > > > > 2.6.15.x and suspend2 2.2.
> > > > > > >
> > > > > > > a) Look in the logs for any oopses, other nasties
> > > > > >
> > > > > > Nothing.
> > > > > >
> > > > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo'
> > > > > > > then find the trace for `hald' in `foo', send it to this list.
> > > > > >
> > > > > > Ok, here it is:
> > > > > >
> > > > > > [ trace snipped ]
> > > > > >
> > > > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > > > >
> > > > > Hopefully suspend2 isn't involved.  People would feel more
> > > > > comfortable if you could test a vanilla mainline tree..
> > > > >
> > > > > Could the ACPI team please take a look at fixing this regression?
> > > >
> > > > I did two cycles with mainline suspend now and did not hit the
> > > > problem... I will keep an eye on it.
> > >
> > > It is independent from suspend version, hald hangs with mainline
> > > suspend as well.
> >
> > I think this is a big regression since 2.5.15. Is anybody working on it?
> > I did not get a reply for nearly a week now...
> > If anybody needs more information let me know.
>
> I would suggest bugging the acpi guys :)

They are in cc, but nobody cares. :(
=2D-=20
Christian

--nextPart6720020.FOX7EZvp2u
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEBAAnlZfG2c8gdSURAjQ6AKC62G4ihhjgBhs1+eS7tV1gWjKmHwCfcz8B
k+kka2GcdLnOaT9nk8GL/Sk=
=A0ne
-----END PGP SIGNATURE-----

--nextPart6720020.FOX7EZvp2u--
