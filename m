Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424154AbWKPPWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424154AbWKPPWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424155AbWKPPWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:22:42 -0500
Received: from lugor.de ([212.112.242.222]:43744 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1424154AbWKPPWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:22:41 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: "Marty Leisner" <leisner@rochester.rr.com>
Subject: Re: RFC  -- /proc/patches to track development
Date: Thu, 16 Nov 2006 16:22:16 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611150117.kAF1H3CD012244@dell2.home>
In-Reply-To: <200611150117.kAF1H3CD012244@dell2.home>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4286274.21nhOl0hyS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611161622.20882.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Thu, 16 Nov 2006 16:22:37 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4286274.21nhOl0hyS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 November 2006 02:17, Marty Leisner wrote:
> I always want to know WHAT I'm running (or people I'm working with
> are running) rather than  "guessing" ("do you have the most current
> patch" "I think so")
>
> I've been a proponent of capturing .config information SOMEPLACE where
> you can look at it at runtime...(it took a while but its there now).
>
>
> In /proc/patches there would be a series of comments (perhaps including
> file, date and time) of various patches you want to monitor.

I prepared such a patch [0] some time ago. It makes the file .patches in=20
kernel source tree available via /proc/patches.gz. Read the discussion on=20
lkml [1] to get more information. It still appies to actual kernels.

[0] http://www.earthworm.de/download/linux/patches.patch
[1]=20
http://groups.google.com/group/linux.kernel/browse_thread/thread/68497374c5=
870617/6cfc8eed92e9b7ff
=2D-=20
Regards,
Christian

--nextPart4286274.21nhOl0hyS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFXIIslZfG2c8gdSURAifEAJ4tujdy85Ny7RCVGdyqKq/HM1+a0wCfSsmg
a+Jvhdj0QV40eMchD8+unNI=
=XBxr
-----END PGP SIGNATURE-----

--nextPart4286274.21nhOl0hyS--
