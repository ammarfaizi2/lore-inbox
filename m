Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWGJVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWGJVtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWGJVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:49:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12191 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S964853AbWGJVtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:49:50 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Tue, 11 Jul 2006 07:49:43 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <1152523109.4874.11.camel@laptopd505.fenrus.org> <20060710100227.GA25310@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060710100227.GA25310@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1395286.jBo4MP7ZlC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607110749.48209.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1395286.jBo4MP7ZlC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 10 July 2006 20:02, Pavel Machek wrote:
> Hi!
>
> > > >>  so that it's as
> > > >> feature-rich as the other one.
> > > >
> > > > this is one of the things that bothers me.
> > > > "features features features"
> > > > lets first get the basics right and working.
> > > > Once we have that in tree for a release or two and it's really
> > > > reliable... THEN and only THEN work on adding features.
> > >
> > > hmm...could it be that we "features, features, features" in suspend2
> > > because nigel & co did get the basics right?
> >
> > As I said... if that is the case then it'd be easy to first merge "the
> > right basics", get that solid, and THEN add the features. So far I've
> > not seen that happen.
>
> Well.. Nigel claims his code can not be split into reasonable chunks.
>
> I actually wanted to get a version without advanced features
> (userspace splash, compression, encryption, plugins), but he claims it
> is not possible. Rafael is trying to persuade him to split out at
> least freezer out...

When did you ask for that? Perhaps I missed it.

The modularity is part of the basis of the redesign, so I couldn't easily=20
remove that. Removing the compression and encryption support is trivial=20
though (one file each, plus Makefile & Kconfig entries - no other=20
modifications needed). Userspace splash - well, just don't compile and=20
install that userspace component - suspend2 will keep working quite happily=
=20
without any userspace app to do a nice display (it will still do printks, s=
o=20
you won't be flying completely blind).

As for the freezer, Rafael doesn't need to persuade me at all. I just need =
to=20
find the time to do what he requested.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1395286.jBo4MP7ZlC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsst8N0y+n1M3mo0RAq4sAKCw6mwhPEZq/OAx9ItyC7PmNgVjZACffMbP
9V79T9LykfEWDj2n9RtsXsg=
=7X00
-----END PGP SIGNATURE-----

--nextPart1395286.jBo4MP7ZlC--
