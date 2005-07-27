Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVG0L24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVG0L24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVG0L2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:28:55 -0400
Received: from lugor.de ([212.112.242.222]:27043 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S262192AbVG0L2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:28:55 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-ck4
Date: Wed, 27 Jul 2005 13:28:38 +0200
User-Agent: KMail/1.8.1
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>
References: <200507272111.27757.kernel@kolivas.org>
In-Reply-To: <200507272111.27757.kernel@kolivas.org>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1871518.OHG5m8KYU5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507271328.45324.mail@earthworm.de>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1871518.OHG5m8KYU5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 July 2005 13:11, Con Kolivas wrote:
> HZ-864.diff
> +My take on the never ending config HZ debate. Apart from the number not
> being pleasing on the eyes, a HZ value that isn't a multiple of 10 is
> perfectly valid. Setting HZ to 864 gives us very similar low latency
> performance to a 1000HZ kernel, decreases overhead ever so slightly, and
> minimises clock drift substantially. The -server patch uses HZ=3D82 for
> similar reasons, with the emphasis on throughput rather than low latency.
> Madness? Probably, but then I can't see any valid argument against using
> these values.

Some time ago I tried with HZ=3D209, but the system then freezes after a fe=
w=20
minutes... Any ideas what could be the reason? Are only even numbers allowe=
d?

=2D-=20
Christian

--nextPart1871518.OHG5m8KYU5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBC52/slZfG2c8gdSURAvQrAJ9KPMUhMVjn5vSHEQL+DY4EksueowCgr8KO
ZhgEP97/ypEDa7bJRU5gesA=
=Y5ny
-----END PGP SIGNATURE-----

--nextPart1871518.OHG5m8KYU5--
