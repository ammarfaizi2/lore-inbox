Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUIXUNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUIXUNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269111AbUIXUNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:13:51 -0400
Received: from garibaldi.swishmail.com ([209.10.110.70]:63240 "HELO
	garibaldi.swishmail.com") by vger.kernel.org with SMTP
	id S269109AbUIXUNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:13:23 -0400
Subject: x86_64: pdflush: page allocation failure. order:0, mode:0x20
From: "Richard F. Rebel" <rrebel@whenu.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/mp9jttTmQp+iP6x3raZ"
Organization: Whenu.com
Message-Id: <1096042401.2297.14.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Fri, 24 Sep 2004 12:13:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/mp9jttTmQp+iP6x3raZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hello,

We recently replaced a dual processor intel system with a dual opteron
250 one.  The new system is running 2.6.3-16 (from our mdk distro).

We have noticed about once a day the system wedges.  Today we got some
debugging info in dmesg.  I cannot list all processes (only some then it
wedges), I can't kill many processes (they never die), and I cannot
reboot.  A hardware reset is required.

We are using XFS on an MD stripe containing 6 disks.  Some directories
on the this filesystem cause ls to wedge when run on them.

If it matters, yes we have 1000bt cards that we do a lot of NFS traffic
over, but no special settings for large frames have been activated.

I saw a similar thread from earlier this year suggesting I increase
/proc/sys/vm/min_free_kbytes, which I did to no avail.

Any insight is appreciated.

pdflush: page allocation failure. order:0, mode:0x20

Call Trace:[<ffffffff80158cba>] [<ffffffff80158dc4>]
[<ffffffff80137340>]=20
       [<ffffffff8015bbe7>] [<ffffffff8015c0c6>] [<ffffffffa000c039>]=20
       [<ffffffffa000ffef>] [<ffffffff802358e5>] [<ffffffff8023974c>]=20
       [<ffffffff80238293>] [<ffffffff80137340>] [<ffffffff802383c0>]=20
       [<ffffffff801778ed>] [<ffffffffa0093de3>] [<ffffffffa009442c>]=20
       [<ffffffff801322f0>] [<ffffffff801322f0>] [<ffffffffa0098ba5>]=20
       [<ffffffffa00948b6>] [<ffffffffa0073b0d>] [<ffffffffa008b595>]=20
       [<ffffffffa0099c09>] [<ffffffff8019223a>] [<ffffffff80192753>]=20
       [<ffffffff80192885>] [<ffffffff801595d0>] [<ffffffff80159b1f>]=20
       [<ffffffff80159550>] [<ffffffff80110327>] [<ffffffff801599d0>]=20
       [<ffffffff8011031f>]=20
pdflush: page allocation failure. order:0, mode:0x20

Call Trace:[<ffffffff80158cba>] [<ffffffff80158dc4>]
[<ffffffff8015bbe7>]=20
       [<ffffffff8015c0c6>] [<ffffffffa000c039>] [<ffffffffa000ffef>]=20
       [<ffffffff802358e5>] [<ffffffff80238eec>] [<ffffffff8023673d>]=20
       [<ffffffffa009442c>] [<ffffffff801322f0>] [<ffffffff801322f0>]=20
       [<ffffffffa0098ba5>] [<ffffffffa00948b6>] [<ffffffffa0073b0d>]=20
       [<ffffffffa008b595>] [<ffffffffa0099c09>] [<ffffffff8019223a>]=20
       [<ffffffff80192753>] [<ffffffff80192885>] [<ffffffff801595d0>]=20
       [<ffffffff80159b1f>] [<ffffffff80159550>] [<ffffffff80110327>]=20
       [<ffffffff801599d0>] [<ffffffff8011031f>]=20


--=20
Richard F. Rebel
rrebel@whenu.com
t. 212.239.0000

--=-/mp9jttTmQp+iP6x3raZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBVEehx1ZaISfnBu0RAtTyAJ9nlo9Mhz5bVmMFFJ0tP/w0CU0/igCeIUhO
3Cpd9xWQ81RqpufsaEuTNy0=
=7R/k
-----END PGP SIGNATURE-----

--=-/mp9jttTmQp+iP6x3raZ--

