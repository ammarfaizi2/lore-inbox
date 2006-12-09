Return-Path: <linux-kernel-owner+w=401wt.eu-S1759760AbWLIXTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759760AbWLIXTT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 18:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759761AbWLIXTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 18:19:19 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:58686 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759747AbWLIXTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 18:19:18 -0500
From: "=?iso-8859-3?q?S=2E=C7a=BBlar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
Date: Sun, 10 Dec 2006 01:19:14 +0200
User-Agent: KMail/1.9.5
Cc: Ismail Donmez <ismail@pardus.org.tr>, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
References: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
In-Reply-To: <20061209172332.2915.qmail@web57808.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2070809.qdZNKm2ilB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612100119.15498.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2070809.qdZNKm2ilB
Content-Type: text/plain;
  charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

09 Ara 2006 Cts 19:23 tarihinde, Rakhesh Sasidharan =BAunlar=B9 yazm=B9=BAt=
=B9:=20
> Infact, just inserting a CD is enough. No need for a media player to try
> and access the files. :)
>
> The backend must be polling and trying to mount the disc upon insertion.
> Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't
> and give error messages. Which explains why downgrading the kernel solves
> the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't
> downgrading the kernel *not* help?) Just thinking aloud ...

But i cannot reproduce the problem that way, in my case dmesg flooded as so=
on=20
as somebody trying to _access_ to VCD. I disabled hal and closed KDE to tes=
t=20
and that problem no longer reproducible for me. So its really seems a=20
userspace problem and i think all of them (KDE's cdpolling backend, hal,=20
mplayer and xine-lib) has problems with kernels >=3D 2.6.17=20

=2D-=20
S.=C7a=BBlar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart2070809.qdZNKm2ilB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFe0Rzy7E6i0LKo6YRAi7eAJ46bPmACoHotSs7iY0KxW4WgxL29QCeMiFQ
I98BRnHpjb7+qzCm6fLhMjU=
=rbOE
-----END PGP SIGNATURE-----

--nextPart2070809.qdZNKm2ilB--
