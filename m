Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTEDSdX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTEDSdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:33:23 -0400
Received: from cpt-dial-196-30-179-171.mweb.co.za ([196.30.179.171]:16257 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261405AbTEDSdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:33:21 -0400
Subject: [2.5] Update sk98lin driver
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aswTJHtGjOXv8kD5+EcC"
Organization: 
Message-Id: <1052073847.4478.18.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 04 May 2003 20:44:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aswTJHtGjOXv8kD5+EcC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I have a 3Com 3c940 gigabit LOM, that is basically a
SysKonnect chipset card.  Here are later drivers that
do support it:

  ftp://ftp.asus.com.tw/pub/ASUS/lan/3com/3c940/041_Linux.zip

The current one in the 2.5 tree was last updated for newer
chipsets in 2001, while the new was updated February this
year.

Anyhow, I got the new to compile, and fixed the few irqreturn_t
calls, and some other 2.5 changes I knew about.

Now the problem is that if I try to load it, I get this:

-----------------------------------------
sk98lin: Unknown symbol __udivdi3
-----------------------------------------

Meaning it linked with libgcc_s.so.  Any ideas why ?

If you need the diff from above source, let me know.  Else
if somebody more experienced is interested in porting it,
I will gladly test.


Thanks,

--=20

Martin Schlemmer




--=-aswTJHtGjOXv8kD5+EcC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+tV93qburzKaJYLYRAo12AJ4oaSHbgWJ7YfoH6ZK2of0pMfvPrQCcCPM9
eRcJBqGzyXNK7ouzROo7ow4=
=qf4d
-----END PGP SIGNATURE-----

--=-aswTJHtGjOXv8kD5+EcC--

