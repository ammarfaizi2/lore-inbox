Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVG2K3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVG2K3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVG2K2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:28:35 -0400
Received: from mx3.mail.ru ([194.67.23.149]:9732 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S262584AbVG2K2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:28:22 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Syncing single filesystem (slow USB writing)
Date: Fri, 29 Jul 2005 14:28:05 +0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200507290731.32694.arvidjaar@mail.ru> <20050728205016.1bdf7288.akpm@osdl.org>
In-Reply-To: <20050728205016.1bdf7288.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20421901.lHdX1vWJWI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291428.06903.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart20421901.lHdX1vWJWI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 29 July 2005 07:50, Andrew Morton wrote:
> > One idea how to improve situation - continue to mount with dsync (having
> > basically old case) and do frequent sync of filesystem (this culd be
> > started as HAL callout or whatever). Unfortunately, I could not find a
> > way to request a sync (flush) of single mount point or block device. Ha=
ve
> > I missed something?
>
> It's trivial to do in-kernel but no, I'm afraid there isn't a userspace
> interface for this.

apparently one should not ask such a question at 7 am. Any reason why=20
BLKFLSBUF does not suite?

--nextPart20421901.lHdX1vWJWI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC6gS2R6LMutpd94wRAk7/AJ0cdP+tRYCXjob+r1dtEKjAsKdxEwCeOvEz
jTScKRW3IEguH8jqpy94bms=
=kHv5
-----END PGP SIGNATURE-----

--nextPart20421901.lHdX1vWJWI--
