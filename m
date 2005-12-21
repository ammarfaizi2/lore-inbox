Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVLUPLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVLUPLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVLUPLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:11:18 -0500
Received: from schokokeks.org ([193.201.54.11]:16062 "EHLO schokokeks.org")
	by vger.kernel.org with ESMTP id S932442AbVLUPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:11:17 -0500
From: "Hanno =?utf-8?q?B=C3=B6ck?=" <mail@hboeck.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: asus_acpi still broken on Samsung P30/P35
Date: Wed, 21 Dec 2005 16:11:49 +0100
User-Agent: KMail/1.9
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Karol Kozimor <sziwan@hell.org.pl>,
       Christian Aichinger <Greek0@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3346709.eu9g7kuGCc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512211611.51977.mail@hboeck.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3346709.eu9g7kuGCc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Since several kernel-versions now the asus_acpi module is broken on several=
=20
Samsung notebooks, it causes an oops when loading and a kernelpanic when=20
compiled into the kernel.

This is known for ages. There was a patch by Karol Kozimor shortly after th=
e=20
bug became public that was ignored.
The code was changed so the patch failed. Christian Aichinger again made a=
=20
patch. It was ignored as well.

Now, finally the patch is in the mm-source, I asked Andrew Morton to push i=
t=20
to Linus so 2.6.15 will be fixed, Andrew said this is up to Len Brown. No=20
Reply from him.

Now it seems that 2.6.15 is going to be released soon, the patch still has =
not=20
made it into linus tree.

This is not "some minor issue", this completely breaks the usage of current=
=20
vanilla-kernels on certain Hardware. Can please, please, please anyone in t=
he=20
position to do this take care that this patch get's accepted before 2.6.15?

The patch is available inside mm-sources or here:
http://www.int21.de/samsung/p30-2.6.14.diff

If I should send it to anyone else or if there's anything I can do to help=
=20
fixing this, I'm glad to help.

cu,

=2D-=20
Hanno B=C3=B6ck		Blog:   http://www.hboeck.de/
GPG: 3DBD3B20		Jabber: jabber@hboeck.de

--nextPart3346709.eu9g7kuGCc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDqXC3r2QksT29OyARAvqFAKCUFsW05hYc4vUcuyyK+iuOqDlg5QCfRDrI
71WfKBazxYIv9Mi8fsuB2V8=
=UW7t
-----END PGP SIGNATURE-----

--nextPart3346709.eu9g7kuGCc--
