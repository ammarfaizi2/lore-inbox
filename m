Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUFYUGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUFYUGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUFYUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:06:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:3297 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S266197AbUFYUFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:05:37 -0400
Date: Fri, 25 Jun 2004 14:05:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Alexander Nyberg <alexn@telia.com>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040625200533.GI31203@schnapps.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Alexander Nyberg <alexn@telia.com>,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen> <20040625191924.GA8656@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0jdOO2+ODOkP2/E4"
Content-Disposition: inline
In-Reply-To: <20040625191924.GA8656@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0jdOO2+ODOkP2/E4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 25, 2004  21:19 +0200, J=F6rn Engel wrote:
> On Wed, 9 June 2004 14:19:19 +0200, Alexander Nyberg wrote:
> > The sendfile() for all file systems remain unusable as it is right now,
> > only works for sending data to socket. But that should be as much
> > performance enhancing as this yes?
>=20
> A similar patch I've once written gave about 10% performance boost
> with warm caches.  Your measurements are with could caches but still
> give a noticeable boost.  Nice.

Yes, it would be nice to get this into the kernel, then eventually have
"cp" test if sendfile() works between two files.  That would allow things
like remote file copy for network filesystems, COW, etc much easier.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--0jdOO2+ODOkP2/E4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA3IWNpIg59Q01vtYRAtPNAJsFrqXjSnrEk19wWPj6W/WKhu2IDwCgltGj
DrI86R8E931V/p638aglO0M=
=n1rD
-----END PGP SIGNATURE-----

--0jdOO2+ODOkP2/E4--
