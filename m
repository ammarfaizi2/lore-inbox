Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTHBUh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTHBUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:37:25 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:15800 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S270291AbTHBUhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:37:24 -0400
Subject: [2.6] Perl weirdness with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com, adilger@clusterfs.com, ext3-users@redhat.com,
       x86-kernel@gentoo.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nYW7MKfrQDdlO19NgvbQ"
Message-Id: <1059856625.14962.19.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 22:37:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nYW7MKfrQDdlO19NgvbQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I have mailed about this previously, but back then it was not
really confirmed, so I have let it be at that.

Anyhow, problem is that for some reason 2.5/2.6 ext3 with HTREE
support do not like what perl-5.8.0 does during installation.
It *seems* like one of the temporary files created during manpage
installation do not get unlinked properly, or gets into the
hash (this possible?) and cause issues.

It seems to work flawless on 2.4 still.

Also, to be honest, I do not have that much free time these days,
so if an interest in helping me/us debug this, it will be appreciated
if some direction in what is needed/suggestions can be given as to what
is required.  There are a few users that experience this issue, and
I am sure that we can get whatever info needed.

A bug on our tracker is here with more (hopefully) complete info:

  http://bugs.gentoo.org/show_bug.cgi?id=3D24991


Thanks,

--=20

Martin Schlemmer




--=-nYW7MKfrQDdlO19NgvbQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/LCDxqburzKaJYLYRAlAlAKCHTl+fK2XAQAPWIE/XXA/Jj5ZZEgCfXcfY
vqhlCXEaJaJf/9ArqcSj2q4=
=yXDo
-----END PGP SIGNATURE-----

--=-nYW7MKfrQDdlO19NgvbQ--

