Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTICLTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTICLTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:19:18 -0400
Received: from smtp5.clb.oleane.net ([213.56.31.25]:20190 "EHLO
	smtp5.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261940AbTICLTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:19:12 -0400
Subject: Re: [ACPI] Where do I send APIC victims?
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: Roger Luethi <rl@hellgate.ch>, Andrew de Quincey <adq@lidskialf.net>,
       Danny ter Haar <dth@ncc1701.cistron.net>,
       Len Brown <len.brown@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gPhcDtqI1RH2+BmB1YDz"
Organization: Adresse personelle
Message-Id: <1062587931.3679.5.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 13:18:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gPhcDtqI1RH2+BmB1YDz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Luethi wrote :
=20
> As the maintainer of via-rhine, I get bug reports that almost in their
> entirety are "fixed" by turning off APIC and/or ACPI. This has been going
> on for several months now. Every now and then, something promising gets
> posted on LKML, but so far if anything I've seen an _increase_ in those b=
ug
> reports. Maybe a fix is floating around and this will be a non-issue RSN.=
 I
> simply can't tell, since I don't have any IO-APIC hardware to play with.

> Instead of just telling everybody to turn off APIC, I'd like to point bug
> reporters to the proper place and tell them what information they should
> provide so it can get fixed for real. According to MAINTAINERS, Ingo Moln=
ar
> does Intel APIC, but the problems are with VIA chip sets. So where do I
> send my users? Any takers?

As far as I can say (as a lowly 2.6 Via user) for 2.5/2.6 the relevant
bug is :

http://bugzilla.kernel.org/show_bug.cgi?id=3D845

Just tell your users to open a new bug (with system info, dmesg,
interrupts, dmidecode,  acpidmp, etc) and make it block bug #845
resolution.

(btw the first registered via acpi bug is november 2002 bug #10, it just
got an initial fix that also worked for another #845 child bug. So
crossing fingers all this will be resolved soonish)

Cheers,

--=20
Nicolas Mailhot

--=-gPhcDtqI1RH2+BmB1YDz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Vc4ZI2bVKDsp8g0RAj3VAKCEAAybwXNekqlfPO0TN4DI/jAbSgCguhP3
mz2q4QCLnRuDr5nyM08nAsQ=
=G5JW
-----END PGP SIGNATURE-----

--=-gPhcDtqI1RH2+BmB1YDz--

