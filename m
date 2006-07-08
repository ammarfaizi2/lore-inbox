Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWGHW2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWGHW2i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWGHW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:28:38 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:47335 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751316AbWGHW2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:28:37 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sun, 9 Jul 2006 08:28:33 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <200607082052.02557.rjw@sisk.pl> <20060708211003.GC2546@elf.ucw.cz>
In-Reply-To: <20060708211003.GC2546@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1287899.4QS5MZ1oan";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607090828.36834.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1287899.4QS5MZ1oan
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 09 July 2006 07:10, Pavel Machek wrote:
> > > It's only too slow on swsusp. With Suspend2, I regularly suspend 1GB
> > > images on both my desktop and laptop machines. I agree that it might =
be
> > > slower on a
>
> uswsusp is as fast as suspend2. It does same LZF compression.

I agree for uncompressed images - I tried timing the writing of the image=20
yesterday. I'm not sure about LZF though, because I couldn't get it to=20
resume. I'd be interested to see it really be as fast as suspend2 with=20
compression.

> > > > Furthermore, I tried to measure how much time would actually be sav=
ed
> > > > if the images were greater than 50% of RAM (current swsusp's limit)
> > > > and it turned out to be 10% at the very last, with compression (on a
> > > > 256MB box with PII).
> > >
> > > I think you'll find that this depends very much on the kind of worklo=
ad
> > > you have, and how you try to compare apples with apples. If you're
> > > running lots of memory intensive apps (say VMware with a couple of
> > > hundred meg allocated, Open Office writer, Kmail, a couple of termina=
ls
> > > and so on - I'm just describing what I normally run), you'll miss that
> > > extra memory more.
>
> Do you think you could get some repeatable benchmark for Rafael? He
> worked quite hard on feature only to find out it makes little difference.=
=2E.

Sure, but it will mean more if all of the tests are run on the same system,=
 so=20
I'll have another go at getting uswsusp to resume, when I get the chance.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1287899.4QS5MZ1oan
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsDGUN0y+n1M3mo0RAt/tAKCdl/QJni37I/JkIXJotHlQ0CMyyACgopWE
F+5iHPHm0tcd1V2Zn+7zLh0=
=A5gn
-----END PGP SIGNATURE-----

--nextPart1287899.4QS5MZ1oan--
