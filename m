Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbUA0VTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUA0VTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:19:47 -0500
Received: from mail-in.m-online.net ([62.245.150.237]:8889 "EHLO
	mail-in.m-online.net") by vger.kernel.org with ESMTP
	id S265683AbUA0VTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:19:46 -0500
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
From: Florian Huber <florian.huber@mnet-online.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: JFS-Discussion <jfs-discussion@oss.software.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040127205324.A19913@infradead.org>
References: <1075230933.11207.84.camel@suprafluid>
	 <1075231718.21763.28.camel@shaggy.austin.ibm.com>
	 <1075232395.11203.94.camel@suprafluid>
	 <1075236185.21763.89.camel@shaggy.austin.ibm.com>
	 <20040127205324.A19913@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hc2vlb5B90ztP4DBv3xV"
Message-Id: <1075238385.14214.3.camel@suprafluid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 22:19:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hc2vlb5B90ztP4DBv3xV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-27 at 21:53, Christoph Hellwig wrote:
> On Tue, Jan 27, 2004 at 02:43:05PM -0600, Dave Kleikamp wrote:
> Yes, it does.  But JFS should get the right size from the gendisk anyway.
> Or did you create the raid with the filesystem already existant?
Yes, i did so.

> While that appears to work for a non-full ext2/ext3 filesystem it's not s=
omething you
> should do because it makes the filesystem internal bookkeeping wrong and
> you'll run into trouble with any filesystem sooner or later.

So, remove the raid, create a new raid "1" with one partiton and create
a jfs fs on top of it, copy all files and add the other disk to the
raid?

--=-Hc2vlb5B90ztP4DBv3xV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFtXwTrkbHdnVDqIRArJDAJ9gfRaePrzX5ZRolk6ohy6SDB+C/wCeMWke
VKMpED9929qKOjKosE+SnNA=
=/OcQ
-----END PGP SIGNATURE-----

--=-Hc2vlb5B90ztP4DBv3xV--

