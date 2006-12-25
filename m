Return-Path: <linux-kernel-owner+w=401wt.eu-S1754572AbWLYXBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbWLYXBU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbWLYXBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 18:01:20 -0500
Received: from iucha.net ([209.98.146.184]:50320 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbWLYXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 18:01:19 -0500
Date: Mon, 25 Dec 2006 16:40:47 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.20-rc2
Message-ID: <20061225224047.GB6087@iucha.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've got an oops or two while copying 60 Gb of files over NFS then
comparing them using diff.  The client is AMD64 running Debian
testing/unstable with the shinny new 2.6.20-rc2 kernel.  The server is
Debian testing with 2.6.18-3 distribution kernel.  The source
filesystem is ext3.

I left the machine to run the diff and when I came back, the USB keyboard
was unresponsive although the USB mice plugged in the hub built into
the keyboard were working fine.  I was able to ssh into the box,
capture the dmesg and reboot.  Everything went down quietly but the
box froze at the "... will restart".  I had no working keyboard and
no way to see if it was indeed frozen or not.

I got a similar event of keyboard loss while copying the files using
2.6.20-rc1.  I was able to copy the files using 2.6.19.

The dmesg from the client machine is attached.
florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFkFNvND0rFCN2b1sRAnkAAJ4t26ahHvpQ7bnqtxAvKMx6hz6uiACeIXEt
b8hFT4n7esQemtFJgkwW65k=
=zv/b
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
