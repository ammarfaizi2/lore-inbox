Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUA0ALq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUA0ALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:11:46 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:56315 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265689AbUA0AKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:10:39 -0500
Date: Tue, 27 Jan 2004 13:12:45 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-reply-to: <20040126232148.GF310@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugang <hugang@soulinfo.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1075162365.18808.4.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-gr0ei5I9PSLrIhOXi8Ud";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074489645.2111.8.camel@laptop-linux>
 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
 <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz>
 <1075154452.6191.91.camel@gaston> <20040126232148.GF310@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gr0ei5I9PSLrIhOXi8Ud
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-27 at 12:21, Pavel Machek wrote:
> Notice that swsusp needs half of physical memory free by design. That
> means that we need _some_ freeing. Nigel's swsusp2 works around that
> at cost of more complicated implementation.

Yes, my method is a bit more complicated.

Yours doesn't always need some freeing though - you only need to free
memory until that 1/2 limitation is met. Last time I looked at it, it
freed memory until it could free no more. Is that still true?

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-gr0ei5I9PSLrIhOXi8Ud
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFaz9VfpQGcyBBWkRAjyUAJ4/quse59VJdsAC6AHd9TnvoP0RVgCfaIIV
yJovgOsiKemDBMc3owBKvzc=
=KWLX
-----END PGP SIGNATURE-----

--=-gr0ei5I9PSLrIhOXi8Ud--

