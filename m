Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVAITou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVAITou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAITou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:44:50 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:61596 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261734AbVAITnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:43:24 -0500
Subject: Possible user base and mainline inclusion of LSM-based security
	improvements.
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Cc: alan@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YzCBB+KhVRZSTzrV0fg6"
Date: Sun, 09 Jan 2005 20:42:53 +0100
Message-Id: <1105299774.8662.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YzCBB+KhVRZSTzrV0fg6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm now writing a "safe networking" LSM, inspired by grSecurity socket
restriction capabilities.

Currently, it provides users and groups (uid and gid based) Access
Control Lists, which can be changed in runtime by a new interface based
on my other LSM, the TPE, which registers a subsystem in sysfs and
creates  the needed entries for "realtime" configuration under secfs in
the mountpoint of sysfs (normally /sys/).

I'ts intended to provide a base of enhanced features inspired by the
well-designed grSecurity patch maintained and developed by Brad Spengler
(a.k.a. spender), by now i have the TPE and this LSM almost done.

The main goal is to provide an also well-designed (as most as possible)
security improvement using the LSM framework for Vanilla sources.

The main problem is that people often needs security enhancements that
they can not get by using the default Vanilla sources, even in an easy,
"user friendly" way.

What's more simple than insmod'ding a module?

Maybe the LSM framework is not the best one, or it's just not reliable
for this as some people and colectives said before, but i want to give
it a chance, even if this work could be nonsense for some people, it's
also for my own fun and coding profit.

If someone wants to help with this idea (i can not call it a project but
seems going to be :) ), just tell me.

Also, i would appreciate knowing the opinion from both kernel hackers
and users "vocal" base, about the inclusion of this security
improvements in the main line.

Tomorrow, my school time will start again after these Christmas
holidays, so, i will have more limited time and less nights (umm, none
maybe) to work on this stuff, until i get spin_unlock()'ed again ;).

Thanks in advance, cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-YzCBB+KhVRZSTzrV0fg6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB4Yk9DcEopW8rLewRAtiuAJ49DJTd2p9um+tPY850JLB2hF8ogwCgrS/5
PD69kGjbSF5iYYi1HJuJBo8=
=QrRH
-----END PGP SIGNATURE-----

--=-YzCBB+KhVRZSTzrV0fg6--

