Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFJGXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFJGXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:23:12 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:992
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262373AbTFJGXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:23:10 -0400
Date: Mon, 9 Jun 2003 23:36:50 -0700
To: Simon Fowler <simon@himi.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-ID: <20030610063650.GA11134@triplehelix.org>
References: <20030610061654.GB25390@himi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20030610061654.GB25390@himi.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2003 at 04:16:54PM +1000, Simon Fowler wrote:
> I've started seeing a hard lockup on boot with my Fujitsu Lifebook
> p2120 laptop, with a radeon mobility M6 LY, when using a Linus bk
> kernel as of 2003-06-09 (possibly earlier - the last kernel I've
> tested is bk as of 2003-06-04). lspci lists this hardware:

That's interesting, my Radeon works fine:

$ dmesg | grep ATI
radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB

But I'm running 2.5.70-mm5, can you try that? If -mm5 works, it will
probably easier to pinpoint the problem.

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+5XyCT2bz5yevw+4RAmm6AJ9pxfozSP0Z85XitpUofIEuR7INrwCffTOE
dqvKvwBw51ZJ+UcEucjVrYI=
=uJp4
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
