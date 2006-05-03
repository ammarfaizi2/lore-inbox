Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWECXkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWECXkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWECXkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:40:16 -0400
Received: from threatwall.zlynx.org ([199.45.143.218]:7629 "EHLO zlynx.org")
	by vger.kernel.org with ESMTP id S1751402AbWECXkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:40:14 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Zan Lynx <zlynx@acm.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, axboe@suse.de,
       nickpiggin@yahoo.com.au, pbadari@us.ibm.com, arjan@infradead.org
In-Reply-To: <20060503201413.34955426.diegocg@gmail.com>
References: <346556235.24875@ustc.edu.cn>
	 <20060502144641.62df9c18.diegocg@gmail.com> <346580906.19175@ustc.edu.cn>
	 <20060502180753.096f8777.diegocg@gmail.com> <346638681.24899@ustc.edu.cn>
	 <20060503201413.34955426.diegocg@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-C67c2wK7+YbO7XLYkfck"
Date: Wed, 03 May 2006 17:39:51 -0600
Message-Id: <1146699591.18747.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C67c2wK7+YbO7XLYkfck
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-03 at 20:14 +0200, Diego Calleja wrote:
> Just for completeness, windows vista will include a enhanced prefetcher
> called (sic) SuperFetch. The idea behind it seems to be to analyze I/O
> patterns and then "mirror" the most frequently used disk blocks into
> the USB flash drive; so if when the usb flash drive is plugged in
> the system will read those blocks from it as it was the hard drive
> the next time you run the app
> (http://www.windowsitpro.com/Windows/Article/ArticleID/48085/48085.html)

Linux should be able to do something like this using unionfs.  It could
be worthwhile to try it with one of the very fastest flash cards or USB
drives.

With slower cards and USB keys its more of a loss unless the faster seek
speed can make up for it, because sequential hard drive access is
faster.

For comparison, a OCZ USB 2.0 Flash Drive with dual channel works at
about 30 MB/s.  One of my 7,200 RPM SATA desktop drives does 45 MB/s.  A
15k SCSI drive can do over 60 MB/s.

It'd be great for laptops though.  My slug of a laptop drive does 20
MB/s on a good day.
--=20
Zan Lynx <zlynx@acm.org>

--=-C67c2wK7+YbO7XLYkfck
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEWT9HG8fHaOLTWwgRAjrGAKCXZWsyjy4wSmmC1S5x4sluRfeE5gCfSGR6
Ced2+FELxsL+W14hhEyDJ04=
=YTOL
-----END PGP SIGNATURE-----

--=-C67c2wK7+YbO7XLYkfck--

