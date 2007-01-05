Return-Path: <linux-kernel-owner+w=401wt.eu-S1161069AbXAELxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbXAELxH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbXAELxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:53:07 -0500
Received: from www.sf-tec.de ([62.27.20.187]:36679 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161069AbXAELxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:53:06 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Date: Fri, 5 Jan 2007 12:54:21 +0100
User-Agent: KMail/1.9.5
References: <20070105063600.GA13571@Ahmed> <200701051126.13682.eike-kernel@sf-tec.de> <20070105103247.GC382@Ahmed>
In-Reply-To: <20070105103247.GC382@Ahmed>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2211652.RijxarK1Ia";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701051254.21618.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2211652.RijxarK1Ia
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 5. Januar 2007 11:32 schrieb Ahmed S. Darwish:
> On Fri, Jan 05, 2007 at 11:26:07AM +0100, Rolf Eike Beer wrote:
> > One big patch for the whole kernel will not work anyway. You have to
> > split it up to allow subsystems to integrate them in their own trees.
> > With one big patch you would get collisions all over the tree causing t=
he
> > complete patch to get dropped. Also CC subsystem maintainers on their
> > parts. And please send the patches as replies to the first one as it
> > cleans up readability of lkml a lot :)
>
> Oops, Just read this warning after sending the (big) patch. Sorry It's my
> first patch :). I'll split it and do as written. Thanks alot :).

That wasn't meant for resending. If you resend the whole series it's good t=
o=20
start a new thread. But if you have several related patches (usually this=20
[PATCH N/xx] thing) it helps if you either send a 0/xx first describing the=
=20
whole series or at least sending everything as reply to 1/xx. This way the=
=20
mail program will help everybody by keeping this things together.

Eike

--nextPart2211652.RijxarK1Ia
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFnjxtXKSJPmm5/E4RAtCtAJ9ICcRg63B0UEVsxk5iO2vH5O5//ACdGaVz
bZItGzyHVJvhbjz4CLrJESE=
=bp8e
-----END PGP SIGNATURE-----

--nextPart2211652.RijxarK1Ia--
