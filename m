Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTJQHqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263329AbTJQHqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:46:43 -0400
Received: from [199.45.143.209] ([199.45.143.209]:53509 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S263328AbTJQHqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:46:42 -0400
Subject: Re: /proc reliability & performance
From: Zan Lynx <zlynx@acm.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1066356438.15931.125.camel@cube>
References: <1066356438.15931.125.camel@cube>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H0+WJ062wtYKk7XoNnOM"
Message-Id: <1066376402.4401.2.camel@titania.zlynx.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 01:40:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H0+WJ062wtYKk7XoNnOM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-16 at 20:07, Albert Cahalan wrote:
> I created a process with 360 thousand threads,
> went into the /proc/*/task directory, and did
> a simple /bin/ls. It took over 9 minutes on a
> nice fast Opteron.

Did you try using find instead of ls?  ls loads all entries and then
sorts them, so it can create an alphabetical display.

Try using find.  It will not take quite so long.
--=20
Zan Lynx <zlynx@acm.org>

--=-H0+WJ062wtYKk7XoNnOM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/j5zSG8fHaOLTWwgRAoh0AJ929lVaKt4iLVt02FOcMMUHW4hLVQCdHIpG
8nS4wYtupmy+157EkTAp+Ts=
=9C2p
-----END PGP SIGNATURE-----

--=-H0+WJ062wtYKk7XoNnOM--

