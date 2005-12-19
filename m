Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVLSTWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVLSTWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLSTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 14:22:08 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59326 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964890AbVLSTWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 14:22:07 -0500
X-Sasl-enc: 16Gk4QAKh34bwfkd+1fgeOWEP48Po9krtGb4Lw4tkhuc 1135020124
Message-ID: <43A70882.80106@imap.cc>
Date: Mon, 19 Dec 2005 20:22:42 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Stephen Hemminger <shemminger@osdl.org>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>	 <43A6E209.5030406@imap.cc> <1135011676.20747.3.camel@mindpipe>
In-Reply-To: <1135011676.20747.3.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5F55410260D6738AAF7436B1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F55410260D6738AAF7436B1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2005-12-19 18:01, Lee Revell wrote:
> On Mon, 2005-12-19 at 17:38 +0100, Tilman Schmidt wrote:
>=20
>>Unfortunately these don't fit our needs, as we are not dealing with a
>>network device, but with an ISDN device.
>=20
> Um, isn't that what the N in ISDN stands for?

While the ISDN is indeed called a network, devices connecting a computer
to it are nevertheless not commonly referred to as network devices.

> I guess what you mean is that although ISDN devices are obviously
> networking devices, the kernel uses a separate subsystem for ISDN?

There's more to it than that. The notion of a "network" is a rather
broad one, including such diverse phenomena as Ethernet, ISDN, TV cable
or even roads or TV stations. The notion of a "network device", on the
other hand, is a quite specific one, at least in the computer world, and
it certainly doesn't include ISDN TAs.

In fact, the operation of an ISDN device is much closer to a modem or
even an answering machine than to that prototypical network device which
is the Ethernet card. This is of course the reason why the Linux kernel
puts them in a subsystem of their own. Making them net_device-s just
wouldn't work.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig5F55410260D6738AAF7436B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDpwiKMdB4Whm86/kRApIuAJkBYxF/4dRpi13GULJnAGV75aIfAACeOrXx
TQ+2X720NifxilnSiqJnjWA=
=hQfp
-----END PGP SIGNATURE-----

--------------enig5F55410260D6738AAF7436B1--
