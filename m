Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUFNOFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUFNOFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUFNOFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:05:33 -0400
Received: from trantor.org.uk ([213.146.130.142]:19605 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263093AbUFNOFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:05:18 -0400
Subject: Re: Local DoS attack on i386 (was: new kernel bug)
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Manuel Arostegui Ramirez <manuel@todo-linux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1087221517.3375.3.camel@sherbert>
References: <200406121159.28406.manuel@todo-linux.com>
	 <1087221517.3375.3.camel@sherbert>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qtbj0C5I6lc3DfBNUsjH"
Date: Mon, 14 Jun 2004 15:05:09 +0100
Message-Id: <1087221909.21569.6.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qtbj0C5I6lc3DfBNUsjH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-14 at 14:58 +0100, Gianni Tedesco wrote:
> Seems to be a scheduler race or something?

sysrq+t shows the offending task (freezes here, doesnt even print "Call
Trace:\n"):

evil    R running   0  1964  1861      (NOTLB)

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-qtbj0C5I6lc3DfBNUsjH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzbCVkbV2aYZGvn0RAnraAJwPcQrBniqwZNX6K2h6Hn9hwwWjTQCfaBs5
19fdUfeUNEJJ9yloo9QrpJE=
=oJFn
-----END PGP SIGNATURE-----

--=-qtbj0C5I6lc3DfBNUsjH--

