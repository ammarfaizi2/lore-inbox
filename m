Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVHJW6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVHJW6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVHJW6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:58:46 -0400
Received: from a213-22-245-91.cpe.netcabo.pt ([213.22.245.91]:18871 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S932588AbVHJW6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:58:46 -0400
Subject: [BUG?] probable underflow on file date on ext2/3 filesystems
From: Carlos Silva <r3pek@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: ext3-users@redhat.com, ext2-devel@lists.sourceforge.net,
       akyms_hm@hotmail.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-10T9spM8cHoQ9kzdEDFb"
Date: Wed, 10 Aug 2005 23:58:24 +0100
Message-Id: <1123714704.13129.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-10T9spM8cHoQ9kzdEDFb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi guys,

        a user at Gentoo Bugzilla, reported that he archives files with
a
artificial timestamp of 1970-01-01 on an ext3 partition on his amd64
box. After remounting that partition, the file date becomes 2106-02-07.
I confirmed this bug and also tested it on several other partitions
(xfs, reiserfs) and they don't have this problem, just ext2 and ext3
have it. This problem also doesn't occur in x86, only on amd64 (as far
as i tested). If any more info is needed, just mail me.
The link to the bug is http://bugs.gentoo.org/101723



Carlos Silva
(cc me as i'm not on the ext2/3 lists)

--=-10T9spM8cHoQ9kzdEDFb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC+oaQttk+BQds59QRAoCzAJ4oerndmelxhX/lI9CWnkLmVcvhawCbBvMg
4VGwWShHou5AZz+CXWFLdNc=
=uXeX
-----END PGP SIGNATURE-----

--=-10T9spM8cHoQ9kzdEDFb--

