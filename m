Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWF2F6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWF2F6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWF2F6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:58:49 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60295 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751582AbWF2F6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:58:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 15:44:14 +1000
User-Agent: KMail/1.9.1
Cc: "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606290937.31174.nigel@suspend2.net> <84144f020606282219n269fffe2i27bdd789758cc268@mail.gmail.com>
In-Reply-To: <84144f020606282219n269fffe2i27bdd789758cc268@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1684670.7iPNciId43";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606291544.18392.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1684670.7iPNciId43
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 29 June 2006 15:19, Pekka Enberg wrote:
> On 6/29/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > Sure, I know where I'd be headed, but it would be a huge waste of time
> > and effort.
>
> Perhaps to you Nigel.  For the rest of us reviewing your patches, it's
> much better.  I suspect it would be better for the users down the road
> as well.  I don't know if you realize it, but what you're doing now
> is, "here's a big chunck of code, take it or leave it".  And at least
> historically people have had hard time doing getting stuff merged like
> that.

I did try really hard not to do that (big chunk of code, take it or leave i=
t).=20
That's why it's split up into so many little patches. The problem seems to =
be=20
that it's not split up in the way some people wanted, rather than not split=
=20
up at all. I want to make it easier on you guys, but it just seems to me li=
ke=20
regardless of what I do, it's not the right thing.

I can understand wanting small changes to swsusp to transform it into=20
suspend2, but I also understand that I've spent approximately 5 years of=20
developing from the point Pavel forked the code base until today, and part =
of=20
that has been two complete reworkings of the way in which the data is store=
d=20
and the thing operates - irreducible complexity that just doesn't fit into=
=20
the incremental change model. So I'm trying to do what seems to me to be th=
e=20
next best thing. Having arranged functions that deal with particular parts =
of=20
the system into individual files, I've broken the files up into logical par=
ts=20
and submitted them in groups. If we consider the more primitive parts first=
,=20
then move to the increasingly abstract operations (or vice versa), I think=
=20
we'll have a good approach with what's already done.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1684670.7iPNciId43
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEo2iyN0y+n1M3mo0RAhqhAKDMKitN3V6ovlIT/DPb35bQK4OQiQCg8vKr
HrVaGAIhYP31T3jkm78qDT8=
=XmhF
-----END PGP SIGNATURE-----

--nextPart1684670.7iPNciId43--
