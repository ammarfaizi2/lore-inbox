Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWGFAhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWGFAhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWGFAhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:37:15 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:51917 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965095AbWGFAhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:37:14 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Thu, 6 Jul 2006 10:37:07 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <200607060940.40678.ncunningham@linuxmail.org> <44AC551B.8090204@zytor.com>
In-Reply-To: <44AC551B.8090204@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1769566.2INcNg3KTL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607061037.11177.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1769566.2INcNg3KTL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 06 July 2006 10:11, H. Peter Anvin wrote:
> Nigel Cunningham wrote:
> > This patch doesn't look right to me. After it is applied, the user will
> > have no way of saying that they don't want to resume (noresume). I assu=
me
> > the removal of resume=3D isn't a problem because you're expecting them =
to
> > use that other undocumented way of setting resume=3D that Pavel mention=
ed a
> > while ago?
>
> Yes, they have.  The handing of resume=3D and noresume are now done in
> kinit; resume is invoked from userspace by direct command only.

Ah. So it's still valid to have resume=3D and noresume on the commandline, =
and=20
klibc greps /proc/cmdline?

So, for Suspend2, would I be ok just leaving people to add the echo=20
> /proc/suspend2/do_resume, as we currently do for initrds and initramfses?

> There is nothing undocumented about it.

Ok. I guess my memory is stale :).

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1769566.2INcNg3KTL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErFs3N0y+n1M3mo0RAlDuAJ9lHkzq5zTwBQkcDVmrM/OZlVOeYwCgo9lT
PJXtbhaTjWSLvTRQFZ9Y9Ko=
=+UzK
-----END PGP SIGNATURE-----

--nextPart1769566.2INcNg3KTL--
