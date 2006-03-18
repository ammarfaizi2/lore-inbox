Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWCRSaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWCRSaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCRSaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:30:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750786AbWCRSaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:30:10 -0500
Message-ID: <441C5185.7030401@redhat.com>
Date: Sat, 18 Mar 2006 10:29:25 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Oleg Nesterov <oleg@tv-sign.ru>, Janak Desai <janak@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@ftp.linux.org.uk, hch@lst.de, mtk-manpages@gmx.net, ak@muc.de,
       paulus@samba.org
Subject: Re: [PATCH] for 2.6.16, disable unshare_vm()
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>  <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>  <441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru> <441C2AA0.3080200@us.ibm.com> <441C4263.B779CDA8@tv-sign.ru> <441C4636.15F57F6@tv-sign.ru> <Pine.LNX.4.64.0603181007020.3826@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603181007020.3826@g5.osdl.org>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39069279EEC53531DA8D6F1C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39069279EEC53531DA8D6F1C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Yes. Quick raising of hands: is there anybody out there that expects to=
=20
> use unshare(CLONE_VM) right now? One of the reasons it was integrated w=
as=20
> that I thought glibc wanted it for distros. Is disabling the CLONE_VM=20
> unsharing going to impact that?

I'm not planning to use unshare(CLONE_VM).  It's not needed for any
functionality planned so far.  What we (as in Red Hat) need unshare()
for now is the filesystem side.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig39069279EEC53531DA8D6F1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEHFGF2ijCOnn/RHQRAjJ8AKC1WWei98EhaDCUVowUkFmGR5O61ACgpqtj
gMXLIFp8U96yBK4vvrrSvpE=
=orvc
-----END PGP SIGNATURE-----

--------------enig39069279EEC53531DA8D6F1C--
