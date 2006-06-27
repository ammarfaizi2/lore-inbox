Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWF0Wjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWF0Wjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWF0Wjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:39:36 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:28893 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1422691AbWF0Wjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:39:35 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
Organization: K Desktop Environment
To: suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?iso-8859-1?q?in=09-mm?=)
Date: Wed, 28 Jun 2006 00:38:59 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz>
In-Reply-To: <20060627222234.GP29199@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2761497.tSBybtbp59";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606280039.06296.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2761497.tSBybtbp59
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 28 June 2006 00:22, Pavel Machek wrote:
> > > uswsusp is a great idea, really.. I love it.. but suspend2 is here, it
> > > works, it's stable and it's now. Why continue to deprive the mainstre=
am
> > > of these features because "uswsusp should".. as yet it doesn't.. and
> > > when it does then we can phase out the currently stable, working
> > > alternative that has all these features that uswsusp _will_ have, aft=
er
> > > it's had them for a year or so and its been proven stable. Not only
> > > that, I'll be happy to migrate over to it. Until then however, you can
> > > pry suspend2.. cold, dead.. blah blah..
> >
> > Given the above explanation, it's obvious that I'm an outside watcher
> > now, but if swsusp2 success rate is clearly higher than the standard
> > version, then I'd also strongly advocate this direction since, quite
> > frankly,
>
> I do not think suspend2 works on more machines than in-kernel
> swsusp. Problems are in drivers, and drivers are shared.
>
> That means that if you have machine where suspend2 works and swsusp
> does not, please tell me. I do not think there are many of them.

Maybe not machines, but definitely usage scenarios. I've tried both=20
implementations lately, and swsusp would often -- especially under high=20
memory load -- just return from trying, while suspend2 succeeds in freeing=
=20
enough memory to be able to suspend _every_ time.=20

Returning with "sorry, not enough free mem" is definitely nothing you'd wan=
t=20
when you stuff your notebook into the bag because you have to change trains=
,=20
for example.

Is that something uswsusp is likely to change anytime soon?
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Experience, n.:   Something you don't get until just after you need it. -=20
Olivier


--nextPart2761497.tSBybtbp59
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKGzimdNh9WRGQ75AQJguwgAmlRhHH0Rqdh8hNOje8LF5ezqWoSn58oi
Nx4ZO/nqx3A3mhZ3/QclXklKjViE3NI1ipk6mCL+xGgTAK5FD40MYHhQzoc8dkJ0
Ebiif5vIOnMoYgZYwS1jNjh9TlPuuI1KB7dHddZ39/xEJGUO5+dpciObJDfzoF+/
oNiWHAvjGgQ9FbJrHpAtlRAcaKLWCmnJ0TtTHZbMHH4/fnHSl3oJ//QU15t5pMyD
7JhrxNkgthZQJwy4lfJn81hp+kB4YawZyB+AfyE7eEo5ccQsrwdMAT5KgjWenyYW
x6rKvvhSGSzbmaszJI7zJpNqwONnNdVfZ4wL7+2D4pSSGVjvV7yLOw==
=n20E
-----END PGP SIGNATURE-----

--nextPart2761497.tSBybtbp59--
