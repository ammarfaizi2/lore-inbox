Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbTIHImo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbTIHImo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:42:44 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:58862 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262077AbTIHImm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:42:42 -0400
Subject: Re: load_LDT_nolock jumped up in the profiles in test4-mm6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20030907215116.GA20847@compsoc.man.ac.uk>
References: <20030907215116.GA20847@compsoc.man.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uWJ4qEAd1mAeb5gX9FJC"
Organization: Red Hat, Inc.
Message-Id: <1063010550.11181.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 08 Sep 2003 10:42:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uWJ4qEAd1mAeb5gX9FJC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-09-07 at 23:51, John Levon wrote:
> I'm running wine under test4-mm6. A new entry has appeared on oprofile's
> vmlinux output :
>=20
>  c01133e0 183433    1.1259     13868     1.8282     load_LDT_nolock

what generation of glibc are you using ?
(more current glibcs, both with or without NPTL, no longer use an LDT)

--=-uWJ4qEAd1mAeb5gX9FJC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/XED2xULwo51rQBIRAqsdAJ9GGr6Xw2uCKV4brGUm7fvTg4wm9gCfQBkV
6Fi1GpBAfWugWlaJGOaGskA=
=qOzG
-----END PGP SIGNATURE-----

--=-uWJ4qEAd1mAeb5gX9FJC--
