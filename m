Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUB1SAb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUB1SAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:00:31 -0500
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:29649 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S261894AbUB1SA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:00:27 -0500
Subject: Re: [PATCH] 2.4.25: Get rid of obsolete LMC driver
From: Daniel Egger <de@axiros.com>
Reply-To: de@axiros.com
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040228144635.A25545@electric-eye.fr.zoreil.com>
References: <1077972033.24149.399.camel@sonja>
	 <20040228144635.A25545@electric-eye.fr.zoreil.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-X+h796qWkUh+VCoLFBvC"
Organization: Axiros GmbH
Message-Id: <1077991287.24150.423.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 19:01:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X+h796qWkUh+VCoLFBvC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, den 28.02.2004 schrieb Francois Romieu um 14:46:

> Shall one understand that:
> - in-kernel LMC driver has been proved dysfunctionnal ?

Hard to tell. Standard Raw HDLC mode works fine but I couldn't find the
correct tools to setup PPP instead. And SBE support is not really
helpful unless you're using their drivers, which had been recently
updated to a version that actually works with late 2.4 kernels.

> - SBE code will be turned into something adequate for kernel integration =
?

Their package consists of tools, a patch and a standalone module source.
Depending on the kernel version the patch needs to be applied, but it
should be in the latest kernels already. The source can be compiled
against any kernel tree and works reasonably well. It probably could be
integrated into the kernel, however given the attitude of SBE and the
senselessness of the rename and some other changes I don't see a good
reason why the community should help them by doing their homework.

Unless there's a reliable driver with working tools I don't see a good
reason to have this driver around. It already bit me hard in the rear
and I'd rather see someone bitch against SBE because their driver is not
working than hunt hours for mistakes and eventually end up with SBE
anyway.

Other than that I've learnt my lesson and selfish as I am, I will not
take it further than I already did.

--=20
Servus,
       Daniel

--=-X+h796qWkUh+VCoLFBvC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQEDXdjBkNMiD99JrAQKBDQgAvwBJyvvDiD+s3xbqWG8Zyj7/3G0i/utv
KCmUEl0fy527zkZKjsBvr/D62LEJZYl4tAlesA/7lFUqf6d5PVDwb/QNxjsYk3IN
q1lCvsAoeCfHN83Q1ZtVojDgcOKxsjubZeKYKtycy1R1y7OWSZ5ci3uBbwjjHyWz
caW0z/bp1MBYEkhACsJYAWs6i4BFquUkuMF3AiJh1oNWmoq5JQ8+itNSzEXV/Iuk
9RZjxb1JD8u88MjaPfgfe/NT6NFmtJLcB8Ci5JhaqclVT7UnypI2mgUEx+swaq4X
oLnCYsXW7NbyhKTljd/Ov9gVLEwIFx/ouWbkQaoFVnQVb9Y433f16Q==
=7Nm3
-----END PGP SIGNATURE-----

--=-X+h796qWkUh+VCoLFBvC--

