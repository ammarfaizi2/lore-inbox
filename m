Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWFVCUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWFVCUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWFVCUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:20:11 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:4903 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964850AbWFVCUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:20:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BYaRK/jxFvvFdleapMBqJ39MNSM0jPRafaQ8CDW6Uah6hslCUQIApziPclzgxt6tw6O/rfsHVJCBB7kmSiTD2wkJlkWRlqcKN5CNaNx2yWifTVqUXkQP0hRN9tWquOYQf9qrviO5O3jeC+L4m5LxAE0IIQPwUNA/MZwTqnC3BkM=
Date: Wed, 21 Jun 2006 22:20:06 -0400
From: Thomas Tuttle <thinkinginbinary@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Ideas for more LED classes/triggers
Message-ID: <20060622022006.GA17754@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey.

I saw the new LED subsystem in 2.6.17.1 (maybe earlier, but maybe it's
been expanded?) and I thought of some ideas for more classes and
triggers.

Classes:
	Keyboard LED's
	Various laptop LED's (Asus, others)
Triggers:
	CPU busy (could include varieties such as user, system, IO wait, etc.
	network device transmit/receive
	wireless device state (associated or not)
	per-disk read/write
	RAID array status

I'm willing to try to write some of these, but I've never worked on any
kernel before, and I'm pretty new to C.  If someone's willing to answer
a few annoying questions as I go, I could probably get some of it done.

Anyway, the LED subsystem looks really cool.  I've always wanted the
kernel to be able to control my blinkenlights instead of having to write
shell scripts.  Keep up the good work!

--=20
Thomas Tuttle (thinkinginbinary@gmail.com)
Your ad here! Discount rates for OSS projects. Email me.
aim/y!m:thinkinginbinary; icq:198113263; jabber:thinkinginbinary@jabber.org
msn: thinkinginbinary@hotmail.com; pgp: 0xAF5112C6

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEmf5W/UG6u69REsYRAg5gAJwLVpTdJGwFQpp4CPzGOD0z1D247wCdGiJb
lwQWZC48rHFwBKSpsTe2tsM=
=Ll3n
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
