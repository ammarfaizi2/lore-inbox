Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUHTU3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUHTU3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHTU3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:29:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:51194 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268706AbUHTUYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:24:39 -0400
Subject: Re: [PATCH] HVSI driver
From: Paul Larson <plars@linuxtestproject.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@lists.linuxppc.org
In-Reply-To: <1092850249.6840.9.camel@localhost>
References: <1092850249.6840.9.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vzFJQ89egO3FSZhasqCP"
Message-Id: <1093033432.9913.106.camel@plars.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 15:23:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vzFJQ89egO3FSZhasqCP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I saw that the HVSI patch made it into 2.6.8.1-mm2 so I decided to play
with it some on my box.  So far, it seems to be working well for me.

I was able to:
-boot with console=3Dhvsi0 and see console messages
-login over an hvsi device
-stable pushing lots of data though it (using things like yes and find
/)
-disconnect and reconnect while pushing data through it without anything
nasty happening
-Ran ppp across hvsi, was able to login via ssh, used tcpspray to stress
it a bit.

I'll keep running with it, but so far it's looking good on my machines.

Thanks,
Paul Larson

On Wed, 2004-08-18 at 12:30, Hollis Blanchard wrote:
> Hi Andrew, this is a console driver for IBM's p5 servers; please
> consider it for inclusion. I've addressed all the comments I've received
> so far.
>=20
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

--=-vzFJQ89egO3FSZhasqCP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJl3XbkpggQiFDqcRAmcUAJ4j1mPjDT4Yd7g6jeE1gZYSUDr8jQCfX+gb
9W8AvlJN44FjZlZwUqZlaC4=
=/NHa
-----END PGP SIGNATURE-----

--=-vzFJQ89egO3FSZhasqCP--

