Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWF0GNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWF0GNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWF0GNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:13:43 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:14507 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1030624AbWF0GNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:13:42 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Jens Axboe <axboe@suse.de>
Subject: Re: [Suspend2][ 0/9] Extents support.
Date: Tue, 27 Jun 2006 15:39:26 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271428.11654.nigel@suspend2.net> <20060627053623.GG22071@suse.de>
In-Reply-To: <20060627053623.GG22071@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2693621.QRqNziUel5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606271539.29540.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2693621.QRqNziUel5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 27 June 2006 15:36, Jens Axboe wrote:
> On Tue, Jun 27 2006, Nigel Cunningham wrote:
> > Hi.
> >
> > On Tuesday 27 June 2006 07:20, Rafael J. Wysocki wrote:
> > > On Monday 26 June 2006 18:54, Nigel Cunningham wrote:
> > > > Add Suspend2 extent support. Extents are used for storing the lists
> > > > of blocks to which the image will be written, and are stored in the
> > > > image header for use at resume time.
> > >
> > > Could you please put all of the changes in kernel/power/extents.c into
> > > one patch? =A0It's quite difficult to review them now, at least for m=
e.
> >
> > I spent a long time splitting them up because I was asked in previous
> > iterations to break them into manageable chunks. How about if I were to
> > email you the individual files off line, so as to not send the same
> > amount again?
>
> Managable chunks means logical changes go together, one function per
> diff is really extreme and unreviewable. Support for extents is one
> logical change, so it's one patch. Unless of course you have to do some
> preparatory patches, then you'd do those separately.
>
> I must admit I thought you were kidding when I read through this extents
> patch series, having a single patch just adding includes!

Sorry for fluffing it up. I'm pretty inexperienced, but I'm trying to follo=
w=20
CodingStyle and all the other advice. If I'd known I'd misunderstood what w=
as=20
wanted, I probably could have submitted this months ago. Oh well. Live and=
=20
learn. What would you have me do at this point?

Regards,

Nigel

=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2693621.QRqNziUel5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEoMSRN0y+n1M3mo0RAic+AJ41U0PETp9YLcKA+sWBlhJ2qfojowCfbymq
nziPpxLUYnfvRPEEMYHVJf0=
=xy9R
-----END PGP SIGNATURE-----

--nextPart2693621.QRqNziUel5--
