Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbUDFPdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDFPdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:33:03 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:55859 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263881AbUDFPcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:32:19 -0400
Subject: Re: reiserfs errors with 2.6.5-rc1-mm2
From: equi-NoX <equi-NoX@wanadoo.fr>
To: Chris Mason <mason@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081254739.4993.82.camel@watt.suse.com>
References: <1081228317.1636.64.camel@ender.WORKGROUP>
	 <1081254739.4993.82.camel@watt.suse.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AoGKimhwjolhhQXiPvcN"
Message-Id: <1081265570.1636.98.camel@ender.WORKGROUP>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Apr 2004 15:32:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AoGKimhwjolhhQXiPvcN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-06 at 12:32, Chris Mason wrote:
> On Tue, 2004-04-06 at 01:11, equi-NoX wrote:
> > oops excuse me :/
> >=20
> > This is one, I can send you others whether you want.
>=20
> Ok, you need to grab the latest reiserfsprogs from ftp.namesys.com and
> run reiserfsck.
>=20
> It's really strange that you've got so many messages about freeing a
> block that is already free for the same two block numbers.  Please send
> along the results of the reiserfsck when you're done.
>=20
> -chris
>=20

but I have already done that ;)

I ran fsck.reiserfs on 04/01, first I ran
fsck.reiserfs /dev/hdb1
then
fsck.reiserfs --fix-fixable /dev/hdb1

but it said me I had to rebuild tree to fix the errors, so I ran
fsck.reiserfs --rebuild-tree /dev/hdb1

And that's ok now


I discovered those reiserfs errors because I was not able to modify some
datas on my /home (which is /dev/hdb1)

I have other logs with reiserfs errors if you want.
Moreover those errors *disappeared* since I use non-mm 2.6.5-rc3 kernel


equi-NoX
--=20
hoping helping

--=-AoGKimhwjolhhQXiPvcN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAcs2hrEI/NqtpJI4RAvcSAJ9JmL5asTl8RlpCclMGHV9FGOTqqACgmVz+
P/jrvO7HclLFBUNBS7STK+s=
=CBgA
-----END PGP SIGNATURE-----

--=-AoGKimhwjolhhQXiPvcN--

