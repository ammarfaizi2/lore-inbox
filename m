Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267174AbUFZPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267174AbUFZPMi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUFZPMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 11:12:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267174AbUFZPMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 11:12:25 -0400
Subject: Re: SATA_SIL works with 2.6.7-bk8 seagate drive, but oops
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, george@galis.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1088253429.9831.1449.camel@cube>
References: <1088253429.9831.1449.camel@cube>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pLcjSgswt+0PRx9c7TGv"
Organization: Red Hat UK
Message-Id: <1088262728.2805.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 26 Jun 2004 17:12:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pLcjSgswt+0PRx9c7TGv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> You never did come up with an alternative to HZ-guessing
> that would work on those old 1200-HZ Alpha boxes, the ARM
> boxes that ran at 64 HZ and so on. I suppose you can blame
> the arch maintainers, but user-space has to deal with it.
> So HZ-guessing is a workaround for a kernel bug, especially
> because you claim that HZ (USER_HZ now) is part of the ABI.

well.... this value is *passed to userspace* via the AT_ attributes ....
glibc probably nicely exports this info via sysconf(). I guess/hope your
tools are now using that ?

--=-pLcjSgswt+0PRx9c7TGv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3ZJIxULwo51rQBIRAvkGAJ97g64WSaM9Cxbu4xzOBW5Zx5WeGwCgoAyN
yHPcJQtvvt3iIef2LF9Y+LI=
=oo0u
-----END PGP SIGNATURE-----

--=-pLcjSgswt+0PRx9c7TGv--

