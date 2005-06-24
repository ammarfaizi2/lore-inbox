Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263275AbVFXVPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbVFXVPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVFXVPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:15:16 -0400
Received: from lugor.de ([217.160.170.124]:15115 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S263220AbVFXVJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:09:52 -0400
From: Christian Hesse <mail@earthworm.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Kernel .patches support
Date: Fri, 24 Jun 2005 23:03:17 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506232358.34897.mail@earthworm.de> <20050624073624.GB26545@stusta.de>
In-Reply-To: <20050624073624.GB26545@stusta.de>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1868539.5UsmYfzxls";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506242303.17813.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1868539.5UsmYfzxls
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 June 2005 09:36, Adrian Bunk wrote:
> On Thu, Jun 23, 2005 at 11:58:27PM +0200, Christian Hesse wrote:
> > Hi everybody,
> >
> > every time I apply a patch to my kernel tree I (or my scripts) make an
> >
> > echo $PATCHNAME $PATCHVERSION >> .patches
> >
> > This patch makes the file accessible via /proc/patches.gz. I think this
> > can be handy if you want to know what patches you (or your distributor)
> > applied to your running kernel...
> >...
> > Let me know what you think.
>
> To be honest, I'm not a fan of it.
>
> If e.g. looking at a Debian kernel source that has 289 different patches
> with names like tty-locking-fixes7 applied, you'll see that this often
> won't give you much valuable information.

You can search Debian lists, archives, ... for "tty-locking-fixes7". After=
=20
that you probably know what the fix is good for.

On the other hand if there is a security fix in a Debian list you can check=
 if=20
your kernel is patched by running "zcat /proc/patches.gz | grep=20
security-fix-foo-bar".

> You'd need an uniform naming convention for patches across
> distributions, and I don't think such things are worth the effort.

If a distribution has a naming convention for itself this patch can already=
 be=20
useful I think. Even without it can be.

=2D-=20
Christian

--nextPart1868539.5UsmYfzxls
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCvHUVlZfG2c8gdSURAvnxAJ9bMPqjPSXWUjG8O5/FVRdaReN+WwCdE+7b
F2+pMDzEPBTWj6kH+N0cKqE=
=ybVq
-----END PGP SIGNATURE-----

--nextPart1868539.5UsmYfzxls--
