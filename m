Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVEWXpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVEWXpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEWXIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:08:51 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:53907 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261167AbVEWWrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:47:10 -0400
Subject: NFS corruption on 2.6.11.7
From: Kenneth Johansson <ken@kenjo.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1KmljD9N/kUQ3qtuFE1M"
Date: Tue, 24 May 2005 00:47:07 +0200
Message-Id: <1116888428.5206.14.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1KmljD9N/kUQ3qtuFE1M
Content-Type: multipart/mixed; boundary="=-SSrSctI2uuI5DhDkITxF"


--=-SSrSctI2uuI5DhDkITxF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have both the server and client running  2.6.11.7 and have some severe
data corruption when reading from the server (maybe on write also I have
not tested).

If I copy the data over with scp or ftp I get correct data. Also  nfs
works OK with a mac os x 10.4 client.

Running gen.sh on the server and then cmp.sh on the client results in a
md5 checksum difference on 5-12 files I have never done one run where
there was no errors.=20

This is what cat /proc/mounts reports on the nfs mount

:/export/home/ken /home/ken nfs rw,v3,rsize=3D32768,wsize=3D32768,hard,udp,=
lock,addr=3Damd 0 0



--=-SSrSctI2uuI5DhDkITxF
Content-Disposition: attachment; filename=gen.sh
Content-Type: application/x-shellscript; name=gen.sh
Content-Transfer-Encoding: base64

IyEgL2Jpbi9lbnYgYmFzaAoKCmxldCBudW09MAoKcm0gc3VtX29yZwo6PnN1bV9vcmcKd2hpbGUg
dGVzdCAkbnVtIC1sdCAzMApkbyAKICBkZCBpZj0vZGV2L3VyYW5kb20gb2Y9JG51bSBicz0xNTAw
MDAwMCBjb3VudD0xICAKICBtZDVzdW0gJG51bSA+PnN1bV9vcmcKICBsZXQgbnVtPSRudW0rMQpk
b25lCgo=


--=-SSrSctI2uuI5DhDkITxF
Content-Disposition: attachment; filename=cmp.sh
Content-Type: application/x-shellscript; name=cmp.sh
Content-Transfer-Encoding: base64

IyEgL2Jpbi9lbnYgYmFzaAoKCmxldCBudW09MAoKcm0gc3VtX25ldwo6PnN1bV9uZXcKd2hpbGUg
dGVzdCAkbnVtIC1sdCAzMApkbyAKICBtZDVzdW0gJG51bSA+PnN1bV9uZXcKICBsZXQgbnVtPSRu
dW0rMQpkb25lCgpkaWZmIHN1bV9vcmcgc3VtX25ldwoK


--=-SSrSctI2uuI5DhDkITxF--

--=-1KmljD9N/kUQ3qtuFE1M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCkl1rmDGOmJIy9x8RAtKqAJ4pRE+AoNEUWs4++6SN8wlXak0U9ACeJfTB
a9I60QCD+4IZboeU4JngK4k=
=bU1Y
-----END PGP SIGNATURE-----

--=-1KmljD9N/kUQ3qtuFE1M--

