Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbUCDUHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUCDUHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:07:45 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42814 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S262107AbUCDUHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:07:44 -0500
Subject: NFS problems with 2.6.4-rc1-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LzRaHk90TugnAy5jbAvq"
Message-Id: <1078430862.3793.5.camel@twins>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 21:07:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LzRaHk90TugnAy5jbAvq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've just build and booted 2.6.4-rc1-mm2, and mounting my NFS exports
works. however when I try to unzip a file over those mount the process
freezes over and any other IO to that mount results in more stuck
processes. SIGKILL will not remove the processes, only reboot will
manage.

dmesg reports like:

nfs: server 192.168.0.1 not responding, timed out

which is total nonsense, because all other hosts on the network can
access the exports just fine.

I'm about to back out all nfs patches from the broken-out patch set to
see what that does for me.

Peter Zijlstra

--=-LzRaHk90TugnAy5jbAvq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAR4yOtCb2m4B45HIRAiu6AJ4xWq3jMjagZ4yPxY5UALPj9QoZuACfb74c
o4I7/VEux0pZrR5v4/+eXBY=
=i5NR
-----END PGP SIGNATURE-----

--=-LzRaHk90TugnAy5jbAvq--

