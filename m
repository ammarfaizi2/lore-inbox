Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUJGUWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUJGUWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJGUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:20:27 -0400
Received: from ex-nihilo-llc.com ([206.114.147.90]:48910 "EHLO
	ex-nihilo-llc.com") by vger.kernel.org with ESMTP id S268052AbUJGUT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:19:28 -0400
Subject: Maximum block dev size / filesystem size
From: Aaron Peterson <aaron@alpete.com>
Reply-To: aaron@alpete.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yZRud9ilAOuEdm4XwwKk"
Message-Id: <1097180361.491.25.camel@main>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 16:19:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yZRud9ilAOuEdm4XwwKk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I work for a company with a 15 TB SAN.  All opinions about the
disadvantages of creating really large filesystems aside, I'm trying to
find out what is the maximum filesystem size we can allocate on our SAN
that a linux box (x86) can really use.

I seem to be finding (from various posts on newsgroups and the kernel
source itself) that block devices with 2.4 kernels cannot exceed 2 TB,
so no matter what the filesystem can theoretically handle, 2 TB is the
practical limit.

I've read that XFS filesystems can theoretically be created up to 18
million TB in size.

What I can't seem to find anywhere is whether the 2 TB block device
limit has improved/grown with 2.6 kernels (on x86 hardware).  Perhaps
I've looked in the wrong places, but I haven't found anything.

If you have any helpful information, or can point me towards a better
place to look I would be very appreciative.

I am not joined to this list, so if you can CC: me in the reply I would
also be grateful.

Aaron

--=-yZRud9ilAOuEdm4XwwKk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (FreeBSD)

iD8DBQBBZaTJeJcyAiXpNL8RAkeRAJ94533t6PRB3lBoOb8+zWAMiZbfDACfTCNU
DIcfYUMxRLfr8x4rZGpsCoU=
=0mFS
-----END PGP SIGNATURE-----

--=-yZRud9ilAOuEdm4XwwKk--

