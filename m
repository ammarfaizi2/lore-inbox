Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWBHHhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWBHHhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWBHHhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:37:13 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:29629 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030574AbWBHHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:37:12 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 17:33:42 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080911.08090.nigel@suspend2.net> <200602080759.50579.rjw@sisk.pl>
In-Reply-To: <200602080759.50579.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2119510.g376gxM4WH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602081733.47134.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2119510.g376gxM4WH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 February 2006 16:59, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Wednesday 08 February 2006 00:11, Nigel Cunningham wrote:
> > On Wednesday 08 February 2006 09:02, Pavel Machek wrote:
> > > > > > Personally I agree with you on suspend2, I think this is someth=
ing that
> > > > > > needed to Just Work yesterday, and every day it doesn't work we=
 are
> > > > > > losing users... but who am I to talk, I'm not the one who will =
have to
> > > > > > maintain it.
> > > > >=20
> > > > > It does just work in mainline now. If it does not please open bug
> > > > > account at bugzilla.kernel.org.
> > > > >=20
> > > > > If mainline swsusp is too slow for you, install uswsusp. If it is
> > > > > still too slow for you, mail me a patch adding LZW to userland co=
de
> > > > > (should be easy).
> > > >=20
> > > > <horrified rebuke>
> > > >=20
> > > > Pavel!
> > > >=20
> > > > Responses like this are precisely why you're not the most popular k=
ernel=20
> > > > maintainer. Telling people to use beta (alpha?) code or fix it
> > >=20
> > > I do not *want* to be the most popular maintainer. That is your place=
 ;-).
> > >=20
> > > > themselves=20
> > > > (and then have their patches rejected by you) is no way to maintain=
 a part=20
> > > > of the kernel. Stop being a liability instead of an asset!
> > >=20
> > > Ugh?
> > >=20
> > > Lee is a programmer. He wants faster swsusp, and improving uswsusp is
> > > currently best way to get that. It may be alpha/beta quality, but
> > > someone has to start testing, and Lee should be good for that (played
> > > with realtime kernels etc...). Actually it is in good enough state
> > > that I'd like non-programmers to test it, too.
> >=20
> > Ok. So Lee might be ok to test uswsusp. But this is your approach
> > regardless of who is emailing you. You consistently tell people to fix
> > problems themselves and send you a patch. That's not what a maintainer
> > should do. They're supposed to maintain, not get other people to do the
> > work. They're supposed to be helpful, not a source of anxiety. You migh=
t be
> > the maintainer of swsusp in name, but you're not in practice. Please, l=
ift
> > your game!
>=20
> I strongly disagree with this opinion.  I don't think there's any problem=
 with
> Pavel, at least I haven't had any problems in communicating with him.

You seem to be the only person around who gets on well with him. Please,
more people step up and tell me I'm wrong. I am only going off the mailing
list afterall, and not daily personal interaction of some other kind.

> Moreover, I don't think the role of maintainer must be to actually write =
the
> code.  From my point of view Pavel is in the right place, because I need
> someone to tell me if I'm going to do something stupid who knows the kern=
el
> better than I do.

By definition, if they don't maintain code, their not a maintainer. If they
only tell someone that they're going to do something stupid, they're a
code reviewer.
=20
> Furthermore, in many cases this is not Pavel who opposes your patches.

Other people have given feedback in the past that has been along the lines
of suggesting improvements / cleanups / whatever, but (feel free to correct
me) no one apart from him has written it off wholesale, told me I'm wasting
my time or the like.

I want to get on with Pavel, I really do. But it's very hard when, despite =
my
best efforts, trying to make allowances for possible misunderstandings and
the like, I never seem to hear a helpful word from him. It's always "No.".
"I don't want that.", and never (so far as I recall) "Here's how you could =
do
that better..", "The idea is ok but the implementation is broken because...=
" or
the like. Perhaps it is (as was said yesterday) just a cultural/language th=
ing,
but I'm not sure.=20

> As we speak there is a discussion on linux-pm regarding a patch that you
> have submitted and I'm sure you are following it.  Please note that Pavel
> hasn't spoken yet, but the patch has already been opposed by at least
> two people.  Is _this_ a Pavel's fault?  No, it isn't.

I haven't seen any replies apart from yours so far. Perhaps there's somethi=
ng
wrong with my mail delivery :(. I'll check the archives.

Nigel
=20
> Greetings,
> Rafael
>=20
>=20
>=20

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2119510.g376gxM4WH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6Z7bN0y+n1M3mo0RAlbaAJ4zogu1SIEsK3kZ0z3qpANGaz5FMwCfcPay
TNH5fiAZ549lSb/Sy1RA+gg=
=7+M/
-----END PGP SIGNATURE-----

--nextPart2119510.g376gxM4WH--
