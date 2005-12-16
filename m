Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVLPA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVLPA6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLPA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:58:17 -0500
Received: from mout2.freenet.de ([194.97.50.155]:61321 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751232AbVLPA6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:58:16 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "Fri, 16 Dec 2005 01:08:02 +0100" <grundig@teleline.es>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 01:57:48 +0100
User-Agent: KMail/1.8.3
References: <20051215212447.GR23349@stusta.de> <43A1E876.6050407@wolfmountaingroup.com> <20051216010802.ed7daadc.grundig@teleline.es>
In-Reply-To: <20051216010802.ed7daadc.grundig@teleline.es>
Cc: rlrevell@joe-job.com, bunk@stusta.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
MIME-Version: 1.0
Message-Id: <200512160157.49165.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart1455115.mUlZHbu71t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1455115.mUlZHbu71t
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 16 December 2005 01:08, you wrote:
> El Thu, 15 Dec 2005 15:04:38 -0700,
> "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribi=F3:
>=20
> > apply to kernel code.  calls from several of our apps (which use
> > larger than 4K kernel space on a stack) from user space crash -- so do=
=20
> > wireless drivers -- and kdb crashes as well with some bugs with 4K stac=
ks
> > turned on when you are trying to debug something.=20
>=20
> If you (or other people) don't report those bugs, nobody else except
> you will care about them, I'm afraid.
>=20
> "My customer says it crashes but I don't want to report it publically".
> What kind of excuse is that? O_o

Your customer runs an -mm kernel on his production systems?
Smash him.
This is about removing 8k support in the -mm kernel, to
find the remaining bugs (if there are any).

=2D-=20
Greetings Michael.

--nextPart1455115.mUlZHbu71t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDohENlb09HEdWDKgRAqOBAJ97KDrezjnLgvSsPlCCPI0vu3qQmACdHkBi
VV0Rh/lyT2ZvoH3tdzBZfSs=
=HSC3
-----END PGP SIGNATURE-----

--nextPart1455115.mUlZHbu71t--
