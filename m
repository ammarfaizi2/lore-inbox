Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWBTUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWBTUaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWBTUaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:30:20 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:52195 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161126AbWBTUaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:30:19 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: dtor_core@ameritech.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 21 Feb 2006 06:27:06 +1000
User-Agent: KMail/1.9.1
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>, "Pavel Machek" <pavel@suse.cz>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140429758.3429.1.camel@mindpipe> <d120d5000602200601l31382264i7c0ef5bdf3d3829a@mail.gmail.com>
In-Reply-To: <d120d5000602200601l31382264i7c0ef5bdf3d3829a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2083947.KDYajHR66p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602210627.12183.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2083947.KDYajHR66p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dimitry.

On Tuesday 21 February 2006 00:01, Dmitry Torokhov wrote:
> On 2/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > > It is slightly slower,
> > >
> > > Sorry, but that is just unacceptable.
> >
> > Um... suspend2 puts extra tests into really hot paths like fork(), which
> > is equally unacceptable to many people.
>
> How bad is it really? From what I saw marking that swsuspend2 branch
> with "unlikely" should help the hot path.
>
> > Why can't people understand that arguing "it works" without any
> > consideration of possible performance tradeoffs is not a good enough
> > argument for merging?
>
> Many of Pavel's arguments are not about performance tradeoffs but
> about perceived complexity of the code. I think if Nigel could run a
> clean up on his implementation and split it into couple of largish
> (not for inclusion but for general overview) pieces, like separate
> arch support, generally useful bits and the rest it would allow seeing
> more clearly how big and invasive swsuspend2 core is.

I'm working on doing that right now. I was starting on it with the plugins=
=20
patches a few weeks ago, and intended to follow it up pretty quickly with t=
he=20
rest. Unfortunately I've gotten sidetracked and overwhelmed by email :) and=
 a=20
lot of other things, so it's taking a lot longer than I wanted.=20
Never-the-less, I'm working towards precisely this.

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2083947.KDYajHR66p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+iYgN0y+n1M3mo0RAg5dAJ0bgBcD9SbEq7OPgN/vbl7Jy7SkRwCgqdLA
ImpBYb8awevljogYe4/ccU8=
=0xdV
-----END PGP SIGNATURE-----

--nextPart2083947.KDYajHR66p--
