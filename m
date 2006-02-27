Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWB0Ws4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWB0Ws4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWB0Wsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:48:55 -0500
Received: from lugor.de ([212.112.242.222]:40917 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1751758AbWB0Wsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:48:53 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Mon, 27 Feb 2006 23:48:37 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <200602221110.44813.mail@earthworm.de> <200602222112.09567.mail@earthworm.de>
In-Reply-To: <200602222112.09567.mail@earthworm.de>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart39355267.8HGVQ3LJXq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602272348.37288.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Mon, 27 Feb 2006 23:48:39 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart39355267.8HGVQ3LJXq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 February 2006 21:12, Hesse, Christian wrote:
> On Wednesday 22 February 2006 11:10, Hesse, Christian wrote:
> > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > Hello everybody,
> > > > > >
> > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in stat=
us
> > > > > > D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints
> > > > > > what could be the problem? It worked perfectly with 2.6.15.x and
> > > > > > suspend2 2.2.
> > > > >
> > > > > a) Look in the logs for any oopses, other nasties
> > > >
> > > > Nothing.
> > > >
> > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' th=
en
> > > > > find the trace for `hald' in `foo', send it to this list.
> > > >
> > > > Ok, here it is:
> > > >
> > > > [ trace snipped ]
> > > >
> > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > >
> > > Hopefully suspend2 isn't involved.  People would feel more comfortable
> > > if you could test a vanilla mainline tree..
> > >
> > > Could the ACPI team please take a look at fixing this regression?
> >
> > I did two cycles with mainline suspend now and did not hit the problem.=
=2E.
> > I will keep an eye on it.
>
> It is independent from suspend version, hald hangs with mainline suspend =
as
> well.

I think this is a big regression since 2.5.15. Is anybody working on it? I =
did=20
not get a reply for nearly a week now...
If anybody needs more information let me know.
=2D-=20
Regards,
Christian

--nextPart39355267.8HGVQ3LJXq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.20 (GNU/Linux)

iD8DBQBEA4HFlZfG2c8gdSURAtfHAKC/NIY8RpYHug4Z8rRF7QowW/2vuwCggs4K
Rrs8sUtwg0lzdBUnsUUYRxA=
=V3Me
-----END PGP SIGNATURE-----

--nextPart39355267.8HGVQ3LJXq--
