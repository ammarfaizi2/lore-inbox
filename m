Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWF1XK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWF1XK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWF1XK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:10:26 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:35275 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1751762AbWF1XKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:10:25 -0400
From: Sebastian =?utf-8?q?K=C3=BCgler?= <sebas@kde.org>
Organization: K Desktop Environment
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?utf-8?q?in=09-mm?=)
Date: Thu, 29 Jun 2006 01:09:53 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606290019.17298.sebas@kde.org> <200606290052.36243.rjw@sisk.pl>
In-Reply-To: <200606290052.36243.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1374419.Z1AT0QbPVT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290109.54294.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1374419.Z1AT0QbPVT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 June 2006 00:52, Rafael J. Wysocki wrote:
> On Thursday 29 June 2006 00:19, Sebastian K=C3=BCgler wrote:
> > On Wednesday 28 June 2006 21:53, Pavel Machek wrote:
> > > Okay, can I get some details? Like how much memory does system have,
> > > what stress test causes the failure?
> >
> > The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB
> > usually made swsusp a problem. I'd need to close apps then to be able to
> > suspend.
>
> That sounds strange to me as I have never had any problems of this kind
> with swsusp and I sometimes have RAM almost 100% full before suspend
> (there's 1.5 GB on my box).
>
> First, have you tried setting the size of the image using
> /sys/power/image_size?

Nope, didn't try that (and only just now read in the docs that it existed).

> Second, the swsusp's memory shrinker has been reworked recently and the
> patch should be in the latest git.  Could you please check if the problems
> persist with the newest -git kernels?

I'll see what I can do, but as I said in the other email, time is limited a=
t=20
the moment.

Thanks for the pointer, though.
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Perfection is achieved not when you have nothing more to add, but when you=
=20
have nothing left to take away. - Antoine de Saint-Exupery


--nextPart1374419.Z1AT0QbPVT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKMMQmdNh9WRGQ75AQLEGggAnrhdwG6Q3yMtkQPJmk9ZRetVnwLnm6X9
v7ow10xuE8L3//PfFWw57KQwS7GU07YGfMeD0/IYvpatO02DbsyuKooIwRD3r4vW
wWUpKedu3p6aIYNJY+7MgaAXOp/QxQR8/IQJ/gTwo2eGdajzbjlqDjQST5FY2upj
rDrvUIxnwr11EkUp2+kc7UJxWJLAx+TGV0apq95R86b37Q1ccJ3jdpuEiYBKmJEh
t4bx4vvuY+EkgrbTrrRI10IF0EDr1DyYA044GcyZK7v1hEz0j8PTKApv+CAkgLHt
Tt6wSZPLeR0wEzLWgAZCHxXPPIKwqEj+NdfzT5x4VLDGs1YdNICBUg==
=8TLB
-----END PGP SIGNATURE-----

--nextPart1374419.Z1AT0QbPVT--
