Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUDDRIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 13:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbUDDRIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 13:08:17 -0400
Received: from cache.dfw.ygnition.net ([66.135.176.7]:12244 "EHLO
	cache.dfw.interquest.net") by vger.kernel.org with ESMTP
	id S262499AbUDDRIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 13:08:15 -0400
Subject: linux 2.4.25 crashes windows
From: Kyle Davenport <kdd@tvmax.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9yfU1VlkeoQXJKRwd0pF"
Message-Id: <1081098190.14744.90.camel@quickest.kyledavenport.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 04 Apr 2004 12:03:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9yfU1VlkeoQXJKRwd0pF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

No joke.  64-bit Windows Advanced Server 2003 blue-screens on file share
access.  I was using Samba 3.0 on RH8 to routinely access windows
shares.  When I upgraded from 2.4.22 to 2.4.25, any attempt to access a
sub-directory of a share mounted from 64-bit Win2003, immediately
crashes windows.  I rolled back to 2.4.22 and no crash.  I tried 2.4.25
against a 32-bit 2003 Win2003, and no crash.  I didn't test different
versions of Samba.  But on 2.4.25, trying to ls a sub-directory of the
mounted share or cd to that sub-directory, instantly and repeatedly
blue-screens windows. =20

I have no idea how the kernel change could be causing this.  Seems to me
like it should depend entirely on Samba.  I did attempt to reproduce the
problem with tcp-replay.  I sent the identical tcp/ip packets involved
without crashing windows.  Apparently share authentication is required.

My company has informed Microsoft of the problem, weeks ago, but I am
getting tired of waiting for a fix.

Congrats to everyone involved!


--=-9yfU1VlkeoQXJKRwd0pF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQBAcD/O1h0kdrrDX8QRAluKAJ4grLghOpnOxBr3KhOK7ORX38xSuwCfUhsa
CchZIl/LD0HxF/611PlqC+o=
=cFkg
-----END PGP SIGNATURE-----

--=-9yfU1VlkeoQXJKRwd0pF--

