Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVEQLis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVEQLis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEQLis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:38:48 -0400
Received: from smtp1.dejazzd.com ([66.109.229.7]:1180 "EHLO
	relay-2.smtp1.dejazzd.com") by vger.kernel.org with ESMTP
	id S261395AbVEQLiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:38:21 -0400
From: "Sean E. Russell" <ser@germane-software.com>
To: Mark Nipper <nipsy@bitgnome.net>
Subject: Re: 2.6.1[01] freeze on x86_64
Date: Tue, 17 May 2005 07:37:25 -0400
User-Agent: KMail/1.8
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
References: <423F5152.2010303@ser1.net> <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr> <20050322131116.GA15512@king.bitgnome.net>
In-Reply-To: <20050322131116.GA15512@king.bitgnome.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17455730.kpXhkadZbC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505170737.26227.ser@germane-software.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart17455730.kpXhkadZbC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 March 2005 08:11, Mark Nipper wrote:
> 	I've actually got old dumb terminals sitting around.
> I'll hook one up and set the oops=3Dpanic option also.  Maybe we
> can nail this down as I've pretty much avoided using my x86-64
> desktop ever since.  I'd been torn trying to decide whether or
> not to migrate to a different file system.

Hah!

I haven't seen Mark post any follow-ups to this, but I have some more=20
information of my own.

Mark, are you running the IPW2200 drivers, by any chance?  I'm pretty sure=
=20
that's what is causing the lock-ups on my end; that, or something in the th=
e=20
kernel's wireless handlers.

I did hook up an ethernet cable and started doing netconsole traces... only=
=20
then the problem disappeared!  To make a long story short, the system is=20
entirely stable when running network over ethernet, but when I use the=20
wireless network interface, it eventually locks up.  There are no error=20
messages that I can associate with the wireless device or network traffic.

=2D-=20
=2D-- SER

"As democracy is perfected, the office of president represents,=20
more and more closely, the inner soul of the people.  On some=20
great and glorious day the plain folks of the land will reach=20
their heart's desire at last and the White House will be adorned=20
by a downright moron."        -  H.L. Mencken (1880 - 1956)

--nextPart17455730.kpXhkadZbC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCidd2P0KxygnleI8RAmztAJ0drV6+mVLaqmExvc+Gx4QtU4v2VgCfYQKh
XWtKaJd+Xgz6krk2yiLmsJo=
=9Bry
-----END PGP SIGNATURE-----

--nextPart17455730.kpXhkadZbC--
