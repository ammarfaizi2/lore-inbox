Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269547AbUJSQUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269547AbUJSQUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269593AbUJSQUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:20:22 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:8849 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S269547AbUJSQSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:18:42 -0400
Date: Tue, 19 Oct 2004 09:18:34 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: John Cherry <cherry@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
Message-ID: <20041019161834.GA23821@one-eyed-alien.net>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These are x86-based stats, yes?  I'm sure other arches will likely tease
out more...

A lot of these seem to be related to readl/writel (readb/writeb, etc).
Those should be straightforward one-line changes, I think... perhaps a job
for more automated scripting?

At the very least, it would be nice to post-process the data to show which
modules are the offenders (and by how much).

Matt

On Tue, Oct 19, 2004 at 07:36:15AM -0700, John Cherry wrote:
> No changes...
>=20
> Linux 2.6 Compile Statistics (gcc 3.2.2)
>=20
> Web page with links to complete details:
>    http://developer.osdl.org/cherry/compile/
>=20
> Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
>              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- -------- ---------
> 2.6.9          0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> 2.6.9-final    0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> 2.6.9-rc4      0w/0e       0w/0e  1930w/0e   41w/0e  11w/0e   1950w/0e
> 2.6.9-rc3      0w/0e       0w/0e  2752w/17e  41w/0e  11w/0e   2782w/5e
> 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
> 2.6.8.1        0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> 2.6.8          0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> 2.6.8-rc4      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> 2.6.8-rc3      0w/0e       0w/0e    78w/ 0e   4w/0e   1w/0e     72w/0e
> 2.6.8-rc2      0w/0e       0w/0e    85w/ 0e   5w/0e   1w/0e     79w/0e
> 2.6.8-rc1      0w/0e       0w/0e    87w/ 0e   5w/0e   1w/0e     82w/0e
> 2.6.7          0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    102w/0e
> 2.6.7-rc3      0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    104w/0e
> 2.6.7-rc2      0w/0e       0w/0e   110w/ 0e   5w/0e   2w/0e    106w/0e
> 2.6.7-rc1      0w/0e       0w/0e   111w/ 0e   6w/0e   2w/0e    107w/0e
> 2.6.6          0w/0e       0w/0e   123w/ 0e   7w/0e   4w/0e    121w/0e
> 2.6.6-rc3      0w/0e       0w/0e   124w/ 0e   7w/0e   5w/0e    121w/0e
> 2.6.6-rc2      0w/0e       0w/0e   122w/ 0e   7w/0e   4w/0e    121w/0e
> 2.6.6-rc1      0w/0e       0w/0e   125w/ 0e   7w/0e   4w/0e    123w/0e
> 2.6.5          0w/0e       0w/0e   134w/ 0e   8w/0e   4w/0e    132w/0e
> 2.6.5-rc3      0w/0e       0w/0e   135w/ 0e   8w/0e   4w/0e    132w/0e
> 2.6.5-rc2      0w/0e       0w/0e   135w/ 0e   8w/0e   3w/0e    132w/0e
> 2.6.5-rc1      0w/0e       0w/0e   138w/ 0e   8w/0e   3w/0e    135w/0e
> 2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e
> 2.6.4-rc2      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
> 2.6.4-rc1      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
> 2.6.3          1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
> 2.6.3-rc4      1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
> 2.6.3-rc3      1w/0e       0w/0e   145w/ 7e   9w/0e   3w/0e    148w/0e
> 2.6.3-rc2      1w/0e       0w/0e   141w/ 0e   9w/0e   3w/0e    144w/0e
> 2.6.3-rc1      1w/0e       0w/0e   145w/ 0e   9w/0e   3w/0e    177w/0e
> 2.6.2          1w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> 2.6.2-rc3      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> 2.6.2-rc2      0w/0e       0w/0e   153w/ 8e  12w/0e   3w/0e    188w/0e
> 2.6.2-rc1      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
> 2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> 2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
> 2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
> 2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
> 2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e
>=20
> Daily compiles (ia32):=20
>    http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
> Latest changes in Linus' bitkeeper tree:
>    http://linux.bkbits.net:8080/linux-2.5
>=20
> John
>=20
>=20
> --=20
> John Cherry
> cherry@osdl.org
> 503-626-2455x29
> Open Source Development Labs
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I think the problem is there's a nut loose on your keyboard.
					-- Greg to Customer
User Friendly, 1/5/1999=20

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBdT5aIjReC7bSPZARAu/5AJ0eqjn5ViUFm/XSHWCuUEO+t+TthQCdES3B
T0TuLWGuNOsFvsgVnNKg1FM=
=gTDP
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
