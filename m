Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUHZInJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUHZInJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHZIkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:40:37 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:11909 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S268015AbUHZIkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:40:19 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
       linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Thu, 26 Aug 2004 01:40:15 -0700
User-Agent: KMail/1.7
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net> <52isb6bj64.fsf@topspin.com> <20040826044954.GP2793@holomorphy.com>
In-Reply-To: <20040826044954.GP2793@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3599965.jVtPeuhKjs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408260140.18328.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3599965.jVtPeuhKjs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 25 August 2004 21:49, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> William> ELF ABI violation. "...the reserved area shall not
> William> consume more than 1GB of the address space."
>
> On Wed, Aug 25, 2004 at 09:46:43PM -0700, Roland Dreier wrote:
> > Agreed, but I do like running with PAGE_OFFSET =3D=3D 0xB0000000 on my
> > main box, which has 1 GB of RAM.  I can avoid highmem and still use
> > the last 128 MB of RAM.  It takes me about 3 seconds to edit
> > <asm/page.h> when I build a new kernel so I'm not arguing for merging
> > this, though.
>
> Though asinine, the ABI spec is set in stone.

And at least one app (valgrind) chokes with as little as 1.25G of reserved=
=20
space.

=2DRyan

--nextPart3599965.jVtPeuhKjs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBLaHyW4yVCW5p+qYRAln4AJ9XWYErb8sHLVVHcjcw3UmQiOELRACgq92H
/a4ZlY9NdWEGQ3RwZHn9kUw=
=rxq9
-----END PGP SIGNATURE-----

--nextPart3599965.jVtPeuhKjs--
