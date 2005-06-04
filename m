Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFDMv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFDMv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFDMv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 08:51:28 -0400
Received: from lugor.de ([217.160.170.124]:64651 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S261338AbVFDMvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 08:51:22 -0400
From: Christian Hesse <mail@earthworm.de>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Date: Sat, 4 Jun 2005 14:51:04 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050602013641.GL21597@atomide.com> <200506030808.12903.mail@earthworm.de> <20050603173940.GA18025@atomide.com>
In-Reply-To: <20050603173940.GA18025@atomide.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1167062.Fs94OfvdaE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506041451.14518.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1167062.Fs94OfvdaE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 03 June 2005 19:39, Tony Lindgren wrote:
[ ... ]
> > Software suspend still does not work, it hangs on resume. Any ideas what
> > could be the cause? I've applied these patches on top of 2.6.12-rc5:
> >
> > 2.6.12-rc4-ck1
> > software suspend 2.1.8.10
> > reiser from 2.6.12-rc5-mm1
> > ieee802.11 stack and ipw2100 1.1.0
> > hostap 0.3.7
> > shfs 0.35
> > fbsplash 0.9.2-r2
> > dyn-tick
>
> I don't think it's the dyn-tick patch that causes it. Does the
> resume work properly without the dyn-tick patch?

I've simply disabled CONFIG_NO_IDLE_HZ, recompiled the kernel and resume wo=
rks=20
perfectly.

But I found another drawback. ping -f reports lots of these errors (though =
it=20
still works):

Warning: time of day goes back (0.122us), taking countermeasures.

=2D-=20
Christian

--nextPart1167062.Fs94OfvdaE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCoaPClZfG2c8gdSURAqVTAKDu9HfJT8KhfqOJ935xIHOoMYdczgCgmnj3
+03IVgq3rCrZSEAxnREEI+4=
=/eBb
-----END PGP SIGNATURE-----

--nextPart1167062.Fs94OfvdaE--
