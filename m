Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTEBHSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 03:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbTEBHSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 03:18:24 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:7365 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S261892AbTEBHSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 03:18:22 -0400
Subject: Re: Centrino
From: Martin List-Petersen <martin@list-petersen.dk>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1051851208.2846.84.camel@marx>
References: <1051851208.2846.84.camel@marx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FGvSJcTSNUlg/GD5lOjd"
Organization: 
Message-Id: <1051860638.24115.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 May 2003 09:30:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FGvSJcTSNUlg/GD5lOjd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-05-02 at 06:53, Anders Karlsson wrote:
> Hi folks,
>=20
> I've been trying to install linux on an IBM X31 Centrino laptop the last
> few days. There are a few things that doesn't work so well. Like agp
> driver (radeon.o) and the IDE subsystem. I've been trying to install it
> with SuSE Pro 8.2 which is using a 2.4.20 kernel. The question I'd like
> to ask is what the Centrino support is like in kernel 2.4.x and 2.5.x
> and what the outlook would be on this should the support be a bit
> lacking.
>
> I have the laptop at home, and I would be willing to try things out to
> get them working, so if there were patches to try out (preferably
> against a 2.4.20 kernel) I'd be happy to do that.

I've got the Dell Latitude D600 (Centrino, ATI Radeon Mobility 9000 32
MB)

The Wlan card is unsupported yet (if you've got that). The AGP drivers
of the Kernel work fine (radeon driver loads without complaining) on
2.4.21-rc1. X needs a tweak, since the Radeon 9000 first will be
supported in 4.3.0. I've started documenting my setup at
http://www.marlow.dk/dell_d600

A lot of the PCI devices are still unknown though (Host Bridge, PCI
Bridge, ISA Bridge, IDE, CardBus Bridge) on lspci

Regards,
Martin List-Petersen
martin at list-petersen dot dk
--
Randal said it would be tough to do in sed.  He didn't say he didn't
understand sed.  Randal understands sed quite well.  Which is why he
uses Perl.   :-)  -- Larry Wall in <7874@jpl-devvax.JPL.NASA.GOV>


--=-FGvSJcTSNUlg/GD5lOjd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sh6ezAGaxP8W1ugRAgJvAJ9D0o8W5x1x2o/cz2TmGZStMCay2ACfZUH+
RTDFxbdVmDeNv8SXnYiLLAw=
=0PAe
-----END PGP SIGNATURE-----

--=-FGvSJcTSNUlg/GD5lOjd--

