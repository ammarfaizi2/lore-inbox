Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUHZUmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUHZUmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269622AbUHZUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:39:52 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:28071 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267770AbUHZUg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:36:27 -0400
Subject: Re: silent semantic changes with reiser4
From: Christophe Saout <christophe@saout.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christer@weinigel.se, spam@tnonline.net,
       akpm@osdl.org, wichert@wiggy.net, jra@samba.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
	 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-93ZxXzE7cHUjN/kDvYMF"
Date: Thu, 26 Aug 2004 22:36:10 +0200
Message-Id: <1093552570.13881.41.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-93ZxXzE7cHUjN/kDvYMF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 26.08.2004, 21:32 +0100 schrieb :

> Argh...  OK, now I remember why I went for -EBUSY for unlink() (we obviou=
sly
> are not bound by SuS on that one).  Consider the following scenario:
> 	* local file foo got something else bound on it for a while
> 	* we are tight on space - time to clean up
> 	* oh, look - contents of foo is junk
> 	* rm foo
> 	* ... oh, fuck, there goes the underlying file.

Right. Good thinking. You can't delete a directory while there regular
files in it either.

Another question: /mnt/test is a mountpoint. Why can I rename `mnt' but
can't rename `test'?


--=-93ZxXzE7cHUjN/kDvYMF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBLkm6ZCYBcts5dM0RApvcAKCMxROH+ugJZw6LlUMzRKlSInpwkQCfQg1I
KW/2Ax+hEGewrv+vJCSoCKs=
=F9+H
-----END PGP SIGNATURE-----

--=-93ZxXzE7cHUjN/kDvYMF--

