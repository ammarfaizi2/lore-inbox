Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVGNAXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVGNAXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGNAXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:23:12 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:40582 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261839AbVGNAWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:22:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
Date: Thu, 14 Jul 2005 10:21:52 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200507122110.43967.kernel@kolivas.org> <200507122202.39988.kernel@kolivas.org> <42D55562.3060908@tmr.com>
In-Reply-To: <42D55562.3060908@tmr.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1164088.dzEjUcc0nh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507141021.55020.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1164088.dzEjUcc0nh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 14 Jul 2005 03:54, Bill Davidsen wrote:
> Con Kolivas wrote:
> > On Tue, 12 Jul 2005 21:57, David Lang wrote:
> >>for audio and video this would seem to be a fairly simple scaleing fact=
or
> >>(or just doing a fixed amount of work rather then a fixed percentage of
> >>the CPU worth of work), however for X it is probably much more
> >> complicated (is the X load really linearly random in how much work it
> >> does, or is it weighted towards small amounts with occasional large
> >> amounts hitting? I would guess that at least beyond a certin point the
> >> liklyhood of that much work being needed would be lower)
> >
> > Actually I don't disagree. What I mean by hardware changes is more along
> > the lines of changing the hard disk type in the same setup. That's what=
 I
> > mean by careful with the benchmarking. Taking the results from an athlon
> > XP and comparing it to an altix is silly for example.
>
> I'm going to cautiously disagree. If the CPU needed was scaled so it
> represented a fixed number of cycles (operations, work units) then the
> effect of faster CPU would be shown. And the total power of all attached
> CPUs should be taken into account, using HT or SMP does have an effect
> of feel.

That is rather hard to do because each architecture's interpretation of fix=
ed=20
number of cycles is different and this doesn't represent their speed in the=
=20
real world. The calculation when interbench is first run to see how many=20
"loops per ms" took quite a bit of effort to find just how many loops each=
=20
different cpu would do per ms and then find a way to make that not change=20
through compiler optimised code. The "loops per ms" parameter did not end u=
p=20
being proportional to cpu Mhz except on the same cpu type.

> Disk tests should be at a fixed rate, not all you can do. That's NOT
> realistic.

Not true; what you suggest is another thing to check entirely, and that wou=
ld=20
be a valid benchmark too. What I'm interested in is what happens if you rea=
d=20
or write a DVD ISO image for example to your hard disk and what this does t=
o=20
interactivity. This sort of reading or writing is not throttled in real lif=
e.

Cheers,
Con

--nextPart1164088.dzEjUcc0nh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC1bAjZUg7+tp6mRURAsKiAJ4tm0AAcRSZO+NDhH+4SkuVlyogswCeJnQd
U+vrckHvPm56c8BEIBF1x40=
=A6F2
-----END PGP SIGNATURE-----

--nextPart1164088.dzEjUcc0nh--
