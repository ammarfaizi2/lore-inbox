Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbTCUBhf>; Thu, 20 Mar 2003 20:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbTCUBhS>; Thu, 20 Mar 2003 20:37:18 -0500
Received: from smtp-out.comcast.net ([24.153.64.110]:24607 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S262713AbTCUBhM>;
	Thu, 20 Mar 2003 20:37:12 -0500
Date: Thu, 20 Mar 2003 20:46:00 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Creating and sending a packet from a kernel module
To: linux-net <linux-net@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1048211160.17980.5.camel@localhost.localdomain>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: multipart/signed; boundary="=-DAwQYbp7mFUpg+0Yd+Xp";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DAwQYbp7mFUpg+0Yd+Xp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'd like to create and send a brand new TCP SYN packet from a module.=20
Does anybody have an example of how to do this.

I've tried doing alloc_skb, filling in all the information I could
imagine needing in skb->data, but what is the minimal amount of stuff
needed by the other parts of the skb to get this packet moving?

Is there an easy way to create and own a TCP socket from a module that I
could send and receive on?

Thanks,
	Josh

--=20
Joshua Stewart <joshua.stewart@comcast.net>

--=-DAwQYbp7mFUpg+0Yd+Xp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+em7Yw1XeqX2OxxURApSWAJ0azweDEVJfbVFWg2bPLC1L2eEefgCglbJq
R42BEtDApXdp/dIeGdXJTp8=
=TfKm
-----END PGP SIGNATURE-----

--=-DAwQYbp7mFUpg+0Yd+Xp--

