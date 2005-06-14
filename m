Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFNKST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFNKST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 06:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVFNKST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 06:18:19 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:7379 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261171AbVFNKSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 06:18:12 -0400
From: Wolfgang Draxinger <wdraxinger@darkstargames.de>
Organization: DARKSTARgames
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-1?q?J=F6rg_Schilling_again=2E=2E=2E_=5BPlease_reply_CC=3A?=
 =?iso-8859-1?q?_wdraxinger?=@darkstargames.de]
Date: Tue, 14 Jun 2005 12:18:21 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1400920.I7kWEcCbKh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506141218.29200.wdraxinger@darkstargames.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1400920.I7kWEcCbKh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A few weeks ago I was updating cdrecord, and as ever when doing=20
updates I'm RTFM (as any user should). Now while doing so I ran about=20
a few lines, complainung about the Linux developers attitude to some=20
patched, and so on, well, the address developers surely know what I=20
mean. However I was disturbed by the fact, that despite a lot of=20
flaming there only few code examples. Admittingly: Not getting back=20
the SCSI error codes is a problem (it somehow reminds me on the GPL=20
vs. BSD joke, where GPL people try to fetch any sort of error while=20
BSD people just don't let errors happen), but communicating with HW=20
it's surely a good idea to do as much error checking possible, as=20
long it's for a sane reason and not just for the heck of it.

So there was this patch by J=F6rg Schilling, which IMHO inroduced a nice=20
solution to the problem, yet keeping compatibility. The awnser by=20
Douglas Gilbert seemed not so elegant to me. However I also know that=20
you don't reject a patch without reason. And this is what I wasn't=20
able to find on the archives.

Lately I had a few emails with J=F6rg and despite his contra Linux=20
attitude (Ok, he likes OpenSolaris more than Linux, so let him do so;=20
but instead of OpenSolaris, which tries to follow a pure academic=20
style, Linux _just works_) I got no information of any real technical=20
value.

Well I didn't cared about the so called issues, as I never had=20
problems with cdrecord - ok the SUID bug required me to workaround,=20
but nothing that a 5 line sh script and a "%cdrw  ALL=3D(ALL)=20
NOPASSWD: /usr/bin/cdrecord.real" rule for sudo can't solve.

But a today's post on heise.de user forums really made me wonder,=20
what's the problem of the guy is - on a pure technically base.

So what's the Linux Kernel developers' opinion on the lack of SCSI=20
error code return, technically?

Happy coding

=2D-=20
Wolfgang Draxinger
lead programmer - DARKSTARgames


--nextPart1400920.I7kWEcCbKh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCrq71BfWmRR/TvT4RAmIFAJ98zb3aPmCL8LCy6LtG5ey1nIoV6QCg6ulr
QmwxXH+stPg1DMrhHo3bg4I=
=tI18
-----END PGP SIGNATURE-----

--nextPart1400920.I7kWEcCbKh--
