Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVBKWc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVBKWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVBKWc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:32:57 -0500
Received: from matheson.swishmail.com ([209.10.110.114]:4844 "EHLO
	matheson.swishmail.com") by vger.kernel.org with ESMTP
	id S262370AbVBKWcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:32:54 -0500
Subject: /proc/*/statm, exactly what does "shared" mean?
From: "Richard F. Rebel" <rrebel@whenu.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sn1V27o5Gp4ZZqaiGTeO"
Organization: Whenu.com
Date: Fri, 11 Feb 2005 17:32:53 -0500
Message-Id: <1108161173.32711.41.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.1.101mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sn1V27o5Gp4ZZqaiGTeO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hello,

I can't seem to find clear documentation about the 'share' column
from /proc/<pid>/statm.

Does this include pages that are shared with forked children marked as
copy-on-write?

Does this only reflect libraries that are dynamically loaded?  What
about shared memory segments/mmaps (ala shmat or mmmap)?

If there is a place where I might find documentation that is more clear
beyond the proc.txt in the kernel docs and then man pages for procfs,
I'd welcome a pointer.

Thanks,

--=20
Richard F. Rebel

cat /dev/null > `tty`

--=-sn1V27o5Gp4ZZqaiGTeO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCDTKVx1ZaISfnBu0RAuCQAJ4zYk+x4WU719cpg33rPnu01RUUBwCggQ3d
GKfcIuEKAK2kYFHTmfbKJXE=
=Hqiy
-----END PGP SIGNATURE-----

--=-sn1V27o5Gp4ZZqaiGTeO--

