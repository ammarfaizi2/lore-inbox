Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267663AbTAHB6I>; Tue, 7 Jan 2003 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbTAHB6I>; Tue, 7 Jan 2003 20:58:08 -0500
Received: from [24.68.68.53] ([24.68.68.53]:2692 "EHLO kruhft")
	by vger.kernel.org with ESMTP id <S267663AbTAHB6G>;
	Tue, 7 Jan 2003 20:58:06 -0500
Date: Tue, 7 Jan 2003 18:06:14 -0800
From: Burton Samograd <kruhft@kruhft.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Getting interface IP addresses with proc filesystem
Message-ID: <20030108020614.GA1480@kruhft.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
X-GPG-key: http://kruhftwerk.dyndns.org/kruhft.pubkey.asc
X-Operating-System: Linux kruhft.dyndns.org 2.4.20 
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm curious how one goes about getting the current IP addresses held by a
machine.  I saw some rather convoluted code in qmail that shows how to do i=
t but
it seems like a rather difficult (and future bug ridden if the interface
changes) piece of code and was thinking that a /proc/net interface would be=
 the
easiest solution, at least on the end user side.

My thinking goes along the lines of adding a file in /proc/net called inter=
faces
(or something more appropriate) which gives the following type of listing:

eth0 12.35.23.58
eth0:0 192.168.0.1
lo 127.0.0.1
ppp0 45.3.3.89

etc

for each of the registered interfaces on the machine.  Nice, simple and
shouldn't be too hard to implement, correct? Is this type of information=20
already present through some other mechanism that I haven't found yet?

Thanks in advance.

--=20
burton samograd
kruhft@kruhft.dyndns.org
http://kruhftwerk.dyndns.org

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+G4eWLq/0KC7fYbURAnTQAJ94hmOwtdNjlSmjPKxyNTerHKPyfgCfcISC
JEmm5Gi0k3AXbZyG47oD3t0=
=gwsW
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
