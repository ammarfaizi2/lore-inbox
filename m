Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271393AbTHDGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 02:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271396AbTHDGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 02:42:26 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:36102 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S271393AbTHDGmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 02:42:25 -0400
Date: Mon, 4 Aug 2003 02:42:22 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Michael Frank <mflt1@micrologica.com.hk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm3-1: Badness in class_dev_release followed by 5 NFS server hangs
Message-ID: <20030804064222.GA11379@babylon.d2dc.net>
Mail-Followup-To: Joshua Kwan <joshk@triplehelix.org>,
	Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030803135641.49d6316e.akpm@osdl.org> <200308040953.42110.mflt1@micrologica.com.hk> <20030804044728.GC5786@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20030804044728.GC5786@triplehelix.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 03, 2003 at 09:47:28PM -0700, Joshua Kwan wrote:
> On Mon, Aug 04, 2003 at 11:10:08AM +0800, Michael Frank wrote:
> > OK, What about the NFS hangs there are more now, also some short in dur=
ation=20
> >=20
> > Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 not responding, still t=
rying
> > Aug  4 04:22:02 mhfl4 kernel: nfs: server mhfl2 OK
> > Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 not responding, still t=
rying
> > Aug  4 04:23:59 mhfl4 kernel: nfs: server mhfl2 OK
>=20
> Interesting, I also see *many* of these on my laptop running
> 2.6.0-test2-mm2. The NFS server is running 2.4.21.

Likewise, though I've never seen the 'OK' bit, it has been happening for
a long while in 2.5.x, however it seems to go away with NFS over TCP.
(Not a fix, but a workaround that does the job for me.)

Zephaniah E. Hull.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"I would rather spend 10 hours reading someone else's source code than
10 minutes listening to Musak waiting for technical support which
isn't."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LgBORFMAi+ZaeAERAre5AJ9ixb8XexdqrDsILi3oIxurKdZOZQCfTWiI
pHdBURW2qHEpbIG5x1pMvxE=
=dIY7
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
