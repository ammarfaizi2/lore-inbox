Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUAZW3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUAZW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:29:48 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:2702 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265560AbUAZW3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:29:46 -0500
Date: Tue, 27 Jan 2004 11:31:50 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-reply-to: <1075154452.6191.91.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1075156310.2072.1.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-fffz+n9Qf1j2/vBE9Wzw";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040119105237.62a43f65@localhost>
 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
 <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz>
 <1075154452.6191.91.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fffz+n9Qf1j2/vBE9Wzw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, 2004-01-27 at 11:00, Benjamin Herrenschmidt wrote:
> Also, at least on pmac laptops, the HD is usually so fast, that
> I suspect spending 10 seconds freeing things is less efficient than
> spending this 10 seconds writing 200Mb of data to disk :) Also, one
> wakup, it's quite painful to see everything be swapped in again. It
> may make sense to be less agressive on the memory freeing, though
> finding a good balance isn't easy.

Yes. That's why suspend2 doesn't free any memory at all by default, but
gives the user the option of setting a maximum image size.

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-fffz+n9Qf1j2/vBE9Wzw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAFZVVVfpQGcyBBWkRAgTMAJoDLqzplfqPS50XbtRM/YX1J9R2PgCfeWO5
eu7sc7JjKLvE4mW5pVDdkTc=
=FGc5
-----END PGP SIGNATURE-----

--=-fffz+n9Qf1j2/vBE9Wzw--

