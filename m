Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263145AbVFXP6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbVFXP6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVFXPyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:54:44 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:15797 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263104AbVFXPua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:50:30 -0400
Date: Fri, 24 Jun 2005 17:50:26 +0200
From: Nico Golde <nico@ngolde.de>
To: linux@brodo.de
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] documentation govenors.txt
Message-ID: <20050624155026.GA10987@ngolde.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
X-Editor: VIM - Vi IMproved 6.3 (2004 June 7, compiled Jun 15 2005 18:17:41)
X-Mailer: Mutt-ng http://www.muttng.org
X-Operating-System: Debian GNU/Linux sid
X-My-Homepage: http://www.ngolde.de
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I corrected a small error and enhanced the govenor.txt file
with the ondemand daemon because the kernel configs link to
the documentation but ondemand wasn't documentated.
Feel free to include the patch in the attachment...
Regards Nico
Please CC me, I am not on the list.
--=20
Nico Golde - JAB: nion@jabber.ccc.de | GPG: 0x73647CFF
http://www.ngolde.de | http://www.muttng.org | http://grml.org=20
VIM has two modes - the one in which it beeps=20
and the one in which it doesn't -- encrypted mail preferred

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="govenors.txt.patch"
Content-Transfer-Encoding: quoted-printable

--- /usr/src/linux/Documentation/cpu-freq/governors.txt	2005-05-27 07:06:46=
=2E000000000 +0200
+++ governors.txt	2005-06-24 16:40:40.000000000 +0200
@@ -9,6 +9,7 @@
=20
=20
 		    Dominik Brodowski  <linux@brodo.de>
+            some additions and corrections by Nico Golde <nico@ngolde.de>
=20
=20
=20
@@ -25,6 +26,7 @@
 2.1  Performance
 2.2  Powersave
 2.3  Userspace
+2.4  Ondemand
=20
 3.   The Governor Interface in the CPUfreq Core
=20
@@ -86,7 +88,7 @@
 scaling_max_freq.
=20
=20
-2.1 Powersave
+2.2 Powersave
 -------------
=20
 The CPUfreq governor "powersave" sets the CPU statically to the
@@ -94,7 +96,7 @@
 scaling_max_freq.
=20
=20
-2.2 Userspace
+2.3 Userspace
 -------------
=20
 The CPUfreq governor "userspace" allows the user, or any userspace
@@ -103,6 +105,14 @@
 directory.
=20
=20
+2.4 Ondemand
+------------
+
+The CPUfreq govenor "ondemand" sets the CPU depending on the
+current usage. To do this the CPU must have the capability to
+switch the frequency very fast.
+
+
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--cNdxnHkX5QqsyA0e--

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCvCvCHYflSXNkfP8RAo66AJwMelFSLNatJrwbNko4A7QsVFbXEwCdGZ5d
/TN2h6YD9c7DQHAiQMRAIg0=
=gzWn
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
