Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUKDSgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUKDSgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKDSfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:35:07 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:11910 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262322AbUKDSdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:33:11 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
Date: Thu, 4 Nov 2004 19:32:31 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>, Erik@budgetdedicated.com,
       "Peter" <peter@rimuhosting.com>,
       "Christopher S. Aker" <caker@theshore.net>,
       Matt Zimmerman <mdz@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10377242.nxt1Ootl8N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411041932.39733.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10377242.nxt1Ootl8N
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You can find all on http://www.user-mode-linux.org/~blaisorblade/.

The SKAS3/2.6-v7 was already released, but I probably forgot to announce it=
=2E=20
So I'm announcing it now.

Changes in SKAS:
* echo 0 > /proc/sysemu on the guests works fine, finally!

Changes in both 2.6.9 and 2.4.27:
they run fine on 2.6.9 host kernels, without hanging at the exit.

Changes in 2.6.9 only:
included a large chunk of JDike tree (excluding all x86_64 related patches)=
,=20
and all the latest security patches from Bodo Stroesser; also it includes t=
he=20
=2DV7 skas patch in it.

Actually, however, to do this I had to include big, invasive patches from J=
eff=20
Dike's tree. I've done it because it's needed and because Bodo Stroesser=20
worked with the incrementals very fine.

Changes in 2.4.27 only:

It's based on a fork from the official 2.4.24-1; the patches I've included=
=20
come almost totally from there, but I dropped all the hostfs rewrite. I als=
o=20
included some incrementals, the one I thought safe.

Also, you can find on the page the instructions to avoid the "hwclock hang"=
 in=20
TT mode. I found the faulty patch, but it needs a more worse bug, which=20
affects everyone running in TT mode on a 2.6 host, so it's included. You ca=
n=20
revert the patch if you want, and if you have to run it on a 2.4 host. I se=
nt=20
a message about this about a week ago, but I got no answer.

Distribution:
* the patch are also in split-out form, both web-browsable and tarballed.
* md5sums are available (to test with "md5sum -c *.md5").

Any testing and report is welcome.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart10377242.nxt1Ootl8N
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBinXHqH9OHC+5NscRAqoSAJ4gt3A6zOHcIEHivBZyYhQDQAXJcwCeLHbF
nPVU2hP4bwab24uVXxN4ft4=
=MlWB
-----END PGP SIGNATURE-----

--nextPart10377242.nxt1Ootl8N--
