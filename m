Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVDNQ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDNQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDNQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 12:59:15 -0400
Received: from rozz.csail.mit.edu ([128.30.2.16]:61824 "EHLO
	rozz.csail.mit.edu") by vger.kernel.org with ESMTP id S261550AbVDNQ5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 12:57:00 -0400
Date: Thu, 14 Apr 2005 12:56:52 -0400
From: Noah Meyerhans <noahm@csail.mit.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM problems with 2.6.11-rc4
Message-ID: <20050414165652.GC28356@csail.mit.edu>
References: <20050315204413.GF20253@csail.mit.edu> <20050315154608.29cee352.akpm@osdl.org> <20050318161217.GH642@csail.mit.edu> <20050413134740.GS1521@opteron.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20050413134740.GS1521@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2005 at 03:47:40PM +0200, Andrea Arcangeli wrote:
> On Fri, Mar 18, 2005 at 11:12:18AM -0500, Noah Meyerhans wrote:
> > Well, that's certainly an interesting question.  The filesystem is IBM's
> > JFS.  If you tell me that's part of the problem, I'm not likely to
> > disagree.  8^)
>=20
> It would be nice if you could reproduce with ext3 or reiserfs (if with
> ext3, after applying the memleak fix from Andrew that was found in this
> same thread ;). The below make it look like a jfs problem.
>=20
> 830696 830639  99%    0.80K 207674        4    830696K jfs_ip

I'll see what I can do.  It may be difficult to move all the data to a
different filesystem.  There are multiple terabytes in use.

I'll refer the JFS developers to this thread, too, they may be able to
shed some light on it.

Thanks.
noah

--=20
Noah Meyerhans                         System Administrator
MIT Computer Science and Artificial Intelligence Laboratory


--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCXqDUYrVLjBFATsMRAgLzAJ9KTVLm6RNLXsKHUEouwzl3245+qQCffvCb
c25MDUTvwU5Nl6DuLkUsv6g=
=G11k
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
