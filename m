Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUHWQ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUHWQ2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHWQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:22:55 -0400
Received: from ppp1-adsl-170.the.forthnet.gr ([193.92.232.170]:24871 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S265887AbUHWQPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:15:32 -0400
From: V13 <v13@priest.com>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] Reread partition table when a partition is added
Date: Mon, 23 Aug 2004 19:14:56 +0300
User-Agent: KMail/1.7
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <200408230119.12878.v13@priest.com> <20040823095318.GB2682@pclin040.win.tue.nl>
In-Reply-To: <20040823095318.GB2682@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2966970.rxEKs3jUU5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408231915.01591.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2966970.rxEKs3jUU5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 23 August 2004 12:53, Andries Brouwer wrote:
> On Mon, Aug 23, 2004 at 01:19:06AM +0300, Stefanos Harhalakis wrote:
> >   This small patch rereads the partition table even if the block device
> > is beeing used. It only rereads it when there are no changes at the
> > current partitions and there are new partitions added at the end. Any
> > existing partition change will/should make it fail.
> >
> >   Is it OK and/or useful ?
>
> What you want is possible already today.
> For an example, see partx in util-linux.

Oh! didn't new about that. Indeed it seems to be the right thing to do (tm)=
=20
regarding partition handling. Util-linux does not build partx by default so=
 I=20
didn't notice it at all.

Thanks!

> Andries
<<V13>>

--nextPart2966970.rxEKs3jUU5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKhgFVEjwdyuhmSoRAtTuAJ9jtm8udACnG0TsjbodWxjU9x89hACgkUHi
0FP6g3nUS/72K7UcnxwJ2tI=
=EoS+
-----END PGP SIGNATURE-----

--nextPart2966970.rxEKs3jUU5--
