Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTKFRfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTKFRfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:35:53 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:27787 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263008AbTKFRfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:35:51 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8/WfgxfvlnRtwWSfEgY9"
Message-Id: <1068140199.12287.246.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 19:36:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8/WfgxfvlnRtwWSfEgY9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-06 at 04:19, David S. Miller wrote:
> On Tue, 2003-05-06 at 02:16, Thomas Horsten wrote:=20
> > The following patch fixes the problem:
>
> Making the u64 swabbing functions unavailable is not an=20
> acceptable solution.=20
>

Sorry to dig this up again, but wont __STRICT_ANSI__ assume
that the program will not use u64 functions (as the program/compiler
is supposed to adhere to ansi standards)?


Thanks,

--=20

Martin Schlemmer



--=-8/WfgxfvlnRtwWSfEgY9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qoanqburzKaJYLYRArrnAJ9V1zctseOQ5iJTRPwKEaJmQV/9KQCfdah9
tGACo2At4ShtTJ0tiXtIhCA=
=a04/
-----END PGP SIGNATURE-----

--=-8/WfgxfvlnRtwWSfEgY9--

