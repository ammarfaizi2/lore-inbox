Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWGHWUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWGHWUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWGHWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 18:20:32 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60133 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751309AbWGHWUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 18:20:32 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Sunil Kumar" <devsku@gmail.com>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Sun, 9 Jul 2006 08:20:25 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Bojan Smojver" <bojan@rexursive.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Avuton Olrich" <avuton@gmail.com>,
       "Olivier Galibert" <galibert@pobox.com>,
       "Jan Rychter" <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <200607082125.12819.rjw@sisk.pl> <ce9ef0d90607081248n1f2fc79fw199b493f3ca6313@mail.gmail.com>
In-Reply-To: <ce9ef0d90607081248n1f2fc79fw199b493f3ca6313@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2285149.h3VDrzu2KN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607090820.29989.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2285149.h3VDrzu2KN
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 05:48, Sunil Kumar wrote:
> > Now there seem to be two possible ways to go:
> > 1) Drop the implementation that already is in the kernel and replace it
> > with
> > the out-of-the-tree one.
> > 2) Improve the one that already is in the kernel incrementally, possibly
> > merging some code from the out-of-the-tree implementation, so that it's
> > as feature-rich as the other one.
> >
> > Apparently 1) is what Nigel is trying to make happen and 2) is what I'd
> > like
> > to do.
>
> Is that really true, Nigel, that you want 1)?

I would be happy for suspend2 and swsusp to coexist for at least at while.=
=20
That's why I've made suspend2 play nicely with swsusp ever since I ported i=
t=20
to 2.6.

> Is it really impossible to have the third possbility of both the
> implementations in kernel at the same time? If Nigel has a patch against =
mm
> series, that means that he has taken care of all the conflicts. Are we
> missing something here?

I just about have one. I just have one issue (the removal of name_to_dev_t =
by=20
klibc) to address. A really simple or short-term solution would be to re-ad=
d=20
it, but I want to think the issue through more carefully first.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart2285149.h3VDrzu2KN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsC+tN0y+n1M3mo0RAmGkAKDF2+PUxjSeEbYwFW4EabGsVKFnRACfQOhO
+Wk1B4m5RS3fvoTVUh4P+g8=
=wiEK
-----END PGP SIGNATURE-----

--nextPart2285149.h3VDrzu2KN--
