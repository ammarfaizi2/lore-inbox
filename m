Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTEBIlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTEBIll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:41:41 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:47252 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S261959AbTEBIku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:40:50 -0400
Subject: Re: Centrino
From: Anders Karlsson <anders@trudheim.com>
To: Martin List-Petersen <martin@list-petersen.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051860638.24115.13.camel@localhost>
References: <1051851208.2846.84.camel@marx>
	 <1051860638.24115.13.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mHtarCO+ljDRTwAIsZRg"
Organization: Trudheim Technology Limited
Message-Id: <1051865588.3599.20.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 02 May 2003 09:53:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mHtarCO+ljDRTwAIsZRg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-02 at 08:30, Martin List-Petersen wrote:

> I've got the Dell Latitude D600 (Centrino, ATI Radeon Mobility 9000 32
> MB)

The X31 has an ATI Mobility Radeon as well, but I don't think it is a
9000. I will double check that when I get home tonight though.

> The Wlan card is unsupported yet (if you've got that). The AGP drivers
> of the Kernel work fine (radeon driver loads without complaining) on
> 2.4.21-rc1. X needs a tweak, since the Radeon 9000 first will be
> supported in 4.3.0. I've started documenting my setup at
> http://www.marlow.dk/dell_d600

I do have the Wlan card and I e-mailed Scott McLaughlin about it. His
response at the time was that Intel was still pondering what they would
do about the drivers. I assume that a gentle stream of plesant e-mails
to the appropriate place at Intel asking nicely for the drivers could
result in the drivers coming available.

The SuSE 2.4.20 kernel does not appear to get along with the X31's
graphics card. I will grab the latest 2.4.21-* kernel and give that a
try. Oh, and the GATOS drm drivers had a decidedly negative impact when
I tried them. I stopped X, removed radeon.o, copied the new radeon.o in
place, started X and experienced a hard hang. Interesting side-effect.

I have bookmarked that page, and I will look in on it now and then. I
should perhaps perform similar documentation for the X31 in case others
try to get Linux working on one.

> A lot of the PCI devices are still unknown though (Host Bridge, PCI
> Bridge, ISA Bridge, IDE, CardBus Bridge) on lspci

Have you seen things like 'hdparm -d1 -X69' failing and telling you that
the actions fail and/or are not allowed? Would you agree that this could
be a side-effect of things you listed not being known to the kernel?

Regards,

/Anders

--=-mHtarCO+ljDRTwAIsZRg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+sjHzLYywqksgYBoRAsoQAJ9rJKCjG8HI3djLz/Ufa7YA7gFPtQCdHjBC
DEsFm3C4j1I40m4PfXBXUCU=
=vo/N
-----END PGP SIGNATURE-----

--=-mHtarCO+ljDRTwAIsZRg--

