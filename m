Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWGDKy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWGDKy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWGDKy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:54:59 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64408 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S932203AbWGDKy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:54:59 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
Date: Tue, 4 Jul 2006 20:54:45 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <200606271634.43662.nigel@suspend2.net> <44A3FE3B.6070103@yahoo.com.au>
In-Reply-To: <44A3FE3B.6070103@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1311891.Bo1uyuu3VK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607042054.55925.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1311891.Bo1uyuu3VK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Nick.

On Friday 30 June 2006 02:22, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > Hi.
> >
> > On Tuesday 27 June 2006 16:11, Nick Piggin wrote:
> >>Nigel Cunningham wrote:
> >>>Add paranoia to the page_alloc code to ensure we don't start page
> >>> reclaim during suspending.
> >>
> >>Nack. Set PF_MEMALLOC if you must.
> >
> > That would work for the thread doing the suspending. What about other
> > kernel threads that might run and allocate memory during the cycle
> > because of $RANDOM_EVENT? We don't want them triggering memory freeing
> > either.
>
> Haven't you suspended the other threads at this point?
>
> What are the consequences of allocating memory?

Did you see my reply to these questions?

Regards,

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1311891.Bo1uyuu3VK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEqkj/N0y+n1M3mo0RAi8+AKDfW7RX9inInpzzjkbHO7twgrARGwCgyBYl
PT72+IkdCzhEzLPE/m2B2wY=
=FtYX
-----END PGP SIGNATURE-----

--nextPart1311891.Bo1uyuu3VK--
