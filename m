Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423321AbWF1Mm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423321AbWF1Mm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423322AbWF1Mm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:42:29 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:13793 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423321AbWF1Mm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:42:28 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rahul Karnik" <rahul@genebrew.com>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Wed, 28 Jun 2006 22:42:21 +1000
User-Agent: KMail/1.9.1
Cc: "Jens Axboe" <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271739.13453.nigel@suspend2.net> <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
In-Reply-To: <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8597459.S8Ea0lr7bV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606282242.26072.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart8597459.S8Ea0lr7bV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 28 June 2006 21:28, Rahul Karnik wrote:
> On 6/27/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > Suspend2 is a
> > reimplementation of swsusp, not a series of incremental modifications. =
It
> > uses completely different methods for writing the image, storing the
> > metadata and so on. Until recently, the only thing it shared with swsusp
> > was the refrigerator and driver model calls, and even now the sharing of
> > lowlevel code is only a tiny fraction of all that is done.
>
> This is something I don't understand. Why can you not submit patches
> that simply do things like "change method for writing image" and
> reduce the difference between suspend2 and mainline? It may be more
> work, but I think you will find that incremental changes are a lot
> easier for people to review and merge.

It's because it's all so interconnected. Adding the modular infrastructure =
is=20
useless without something to use the modules. Changing to use the pageflags=
=20
functionality requires modifications in both the preparation of the image a=
nd=20
in the I/O. There are bits that could be done incrementally, but they're=20
minor. I did start with the same codebase that Pavel forked, but then did=20
substantial rewrites in going from the betas to 1.0 and to 2.0.

Thanks for the email.

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart8597459.S8Ea0lr7bV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEonkyN0y+n1M3mo0RAkIGAJ0d9E1RBy3ApdMQY2wFFUnPkgMUPQCcCp57
TAxPr8d2x4QL72lcp6OeabA=
=JwO9
-----END PGP SIGNATURE-----

--nextPart8597459.S8Ea0lr7bV--
