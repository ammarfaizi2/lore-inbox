Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272074AbTHDStn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272140AbTHDStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:49:43 -0400
Received: from net28ip52nit.parklink.com ([192.204.28.52]:4480 "EHLO
	okcomputer") by vger.kernel.org with ESMTP id S272074AbTHDStj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:49:39 -0400
Subject: [Fwd: Re: Yenta init freezes Pavilion]
From: Pat Rondon <pat@thepatsite.com>
Reply-To: pat@thepatsite.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5ieHuPlq+YqOR8bMPKmq"
Message-Id: <1060022978.3736.3.camel@okcomputer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 04 Aug 2003 14:49:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5ieHuPlq+YqOR8bMPKmq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-04 at 05:26, Russell King wrote:
> Which kernel exhibited this behaviour, and which was the last kernel
> which didn't?

  Sorry, can't believe I forgot this- this is with 2.6-test2-bk3.  I'll
have info on which kernel was the last to not exhibit this behavior
tonight, I hope (school, work, etc. in the way).

> Also, there should be other messages about pcmcia around that area -
> it would be helpful to include those in your report.

  Just IDE messages.
  Booting without the mentioned options, if I let it sit long enough, I
get the following message quite a few times:

swapper: page allocation failure. order:0, mode:0x20

  Also, if I hit the power button while it's frozen, it continues
booting- obvious problem with ACPI/PCMCIA, I suppose?
  Today it's actually sometimes booting to init without the pci/acpi
options (it seems to depend on whether I have a card in the slot,
actually), but at some point I get the following never-ending series of
errors:

  ACPI-0398: *** Error: acpi_ev_gpe_dispatch: No handler or method for
GPE[xx], disabling event

Thanks for helping me help. ;-)

--=-5ieHuPlq+YqOR8bMPKmq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/LqrCruzBsw43EvgRAq5dAJ9Tq3T054so8+FH6PEwO76QKzMscwCggKXD
ExUJGEplSwau+F2haW9blU0=
=+ef8
-----END PGP SIGNATURE-----

--=-5ieHuPlq+YqOR8bMPKmq--

