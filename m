Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHRWjD>; Sun, 18 Aug 2002 18:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSHRWjD>; Sun, 18 Aug 2002 18:39:03 -0400
Received: from monster.nni.com ([216.107.0.51]:54798 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S316446AbSHRWjC>;
	Sun, 18 Aug 2002 18:39:02 -0400
Date: Sun, 18 Aug 2002 18:41:35 -0400
From: Andrew Rodland <arodland@noln.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
Message-Id: <20020818184135.66fe0ba2.arodland@noln.com>
In-Reply-To: <1029695363.1357.5.camel@psuedomode>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu>
	<1029662182.2970.23.camel@psuedomode>
	<1029694235.520.9.camel@psuedomode>
	<6un0rkuiyg.fsf@zork.zork.net>
	<1029695363.1357.5.camel@psuedomode>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.282Vh:JMiTZ4?S"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.282Vh:JMiTZ4?S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 18 Aug 2002 14:29:23 -0400
Ed Sweetman <safemode@speakeasy.net> wrote:

> I know i have no device nodes.  I removed them all before installing
> devfs.  

Well then you have no device nodes without devfs. D'uh? :)

> the devfs documentation says it doesn't need to have devfs
> mounted to work, but this doesn't seem to be true at all.

No, the devfs documentation says that it is "safe" to have devfs
compiled in and not use it -- you will just use the standard /dev. It
does not imply in any way that you will be using devfs if you don't
mount it, it says that if you choose _not_ to use devfs, then it will be
able to fall cleanly back to standard /dev. In other words,
CONFIG_DEVFS_FS provides the _ability_ to use devfs, not a
_requirement_. 

That's all it says.
To assume that it means anything else would be incredibly silly.

--=.282Vh:JMiTZ4?S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9YCKlQ3MWXxdwvVwRAqYCAKCdUreDeQoeuNaB9ZRoMvl7tqvskgCgjiqn
2AKPpc43dttz0ccOP67Bct8=
=RxEN
-----END PGP SIGNATURE-----

--=.282Vh:JMiTZ4?S--
