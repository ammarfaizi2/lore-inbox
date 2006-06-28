Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751772AbWF1Xhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWF1Xhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWF1Xhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:37:35 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1953 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751772AbWF1Xhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:37:35 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Thu, 29 Jun 2006 09:37:27 +1000
User-Agent: KMail/1.9.1
Cc: "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606282242.26072.nigel@suspend2.net> <84144f020606280742v348bdf53w96bd790362abaff9@mail.gmail.com>
In-Reply-To: <84144f020606280742v348bdf53w96bd790362abaff9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1345679.Y2AiGdoMg9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290937.31174.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1345679.Y2AiGdoMg9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 29 June 2006 00:42, Pekka Enberg wrote:
> Hi Nigel,
>
> On 6/28/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > It's because it's all so interconnected. Adding the modular
> > infrastructure is useless without something to use the modules. Changing
> > to use the pageflags functionality requires modifications in both the
> > preparation of the image and in the I/O. There are bits that could be
> > done incrementally, but they're minor. I did start with the same codeba=
se
> > that Pavel forked, but then did substantial rewrites in going from the
> > betas to 1.0 and to 2.0.
>
> Hmm, so, if you leave out the controversial in-kernel stuff like, user
> interface bits, "extensible API", compression, and crypto, are you
> saying there's nothing in suspend2 that can be merged separately?

My point was that the architecture of Suspend2 is fundamentally different t=
o=20
that of swsusp. Suspend2 features could potentially be added to swsusp, but=
=20
it would require a lot of work on swsusp. I've worked hard to make Suspend2=
=20
clean and ready for merging. I'm not claiming it's perfect (we've already=20
seen a few cleanups I missed), but I fail to see why I should be made to do=
=20
even more work on the old version when I've already said that getting from =
it=20
to Suspend2 involved substantial rewrites. Sure, I know where I'd be headed=
,=20
but it would be a huge waste of time and effort.

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1345679.Y2AiGdoMg9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoxK7N0y+n1M3mo0RAlYTAKDPskm8Zk1eLLrbVLa/4VmTYRvvyQCbB2QY
opN7gTS9cFU9xQm4vlrP/sY=
=k2A0
-----END PGP SIGNATURE-----

--nextPart1345679.Y2AiGdoMg9--
