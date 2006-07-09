Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbWGIVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWGIVGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWGIVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:06:46 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:42689 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161153AbWGIVGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:06:45 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 07:06:38 +1000
User-Agent: KMail/1.9.1
Cc: Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Arjan van de Ven <arjan@infradead.org>, Sunil Kumar <devsku@gmail.com>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
References: <20060627133321.GB3019@elf.ucw.cz> <1152407148.2598.10.camel@coyote.rexursive.com> <200607091551.18456.rjw@sisk.pl>
In-Reply-To: <200607091551.18456.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1773496.5vK2jvxWB4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607100706.45789.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1773496.5vK2jvxWB4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 09 July 2006 23:51, Rafael J. Wysocki wrote:
> On Sunday 09 July 2006 03:05, Bojan Smojver wrote:
> > On Sun, 2006-07-09 at 02:32 +0200, Pavel Machek wrote:
> > > I wanted to point out that delay between "okay, I want this gone" and
> > > the code disappearing from kernel tarball is about a year.
> >
> > OK, so the period for this kind of solution(s) to completely go away is
> > even longer.
> >
> > Which brings me to my point. Given that with my proposal you would have
> > zero involvement with Suspend2 code (i.e. you would not be obligated to
> > fix/touch/do anything in *any way*), why not give Nigel a go? The man is
> > obviously willing to do stuff on his own and it won't cost you anything.
>
> The problem is he _can't_ do it on his own if he wants the code merged,
> because for this purpose some people have to review it, and that's not
> only me or Pavel, but also architecture maintainers, memory management
> maintainers, and probably some other people too.  Moreover, Nigel needs
> to address the issues raised by the reviewers.
>
> > And if it doesn't work out - well, though luck for Nigel.
>
> Some people have reviewed some parts of suspend2 recently and there
> were some comments to address.  Now it's up to Nigel to address them or
> not, and that's only the tip of the iceberg.  It'll take quite some time =
to
> review the entire suspend2 and address all of the issues that people may
> have with it.  This is a long way to go, but I personally am not against
> doing it.
>
> Now there's the separate problem that we have to share _some_ code.
> To an absolute minimum, we have to share the freezer code and the
> code that handles devices, because it's also shared by suspend-to-RAM.
> The code that handles devices is already shared, but we also _have_ _to_
> share the freezer code.  Therefore, as long as suspend2 adds some code
> to the freezer, it's not even close to be considerable for merging.

If Suspend2 added code in a way that broke swsusp, I would agree. But it=20
doesn't.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1773496.5vK2jvxWB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEsW/lN0y+n1M3mo0RAqnXAJ9qLNn2kM+U+LyyHm1KM+jNCTbGUQCeI9GS
FX3KkKm1w0cRwG37v46uP2g=
=TYNn
-----END PGP SIGNATURE-----

--nextPart1773496.5vK2jvxWB4--
