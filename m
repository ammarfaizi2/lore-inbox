Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJZEZd>; Sat, 26 Oct 2002 00:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSJZEZd>; Sat, 26 Oct 2002 00:25:33 -0400
Received: from [216.38.156.94] ([216.38.156.94]:1549 "EHLO mail.networkfab.com")
	by vger.kernel.org with ESMTP id <S261853AbSJZEZc>;
	Sat, 26 Oct 2002 00:25:32 -0400
Subject: Re: Orinoco gold car locking up under sustained load
From: Dmitri <dmitri@users.sourceforge.net>
To: Tony.Lill@ajlc.waterloo.on.ca
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210260403.g9Q43R901903@spider.ajlc.waterloo.on.ca>
References: <200210260403.g9Q43R901903@spider.ajlc.waterloo.on.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z+DWvCJhvh2UUYYfw8XD"
Organization: 
Message-Id: <1035606707.14594.114.camel@usb.networkfab.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 25 Oct 2002 21:31:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z+DWvCJhvh2UUYYfw8XD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-25 at 21:03, Tony Lill wrote:

> Linux 2.4.17 laptop with an orinoco gold and AP-500. I'm trying to
> backup some stuff useing 'ssh tardis tar cf -' After about an hour or
> so, the card locks up with both led's going dim.

Maybe the card just overheated? Do those LEDs normally ever go dim?
These cards draw a considerate amount of power, so it is conceivable
that either the card, or the CardBus power switch decided to take a
vacation elsewhere... Looking at the log, it seems that the card just
disappeared - which would be consistent with hardware failure, and power
failure in particular.

> Oct 20 05:43:36 tardis kernel: hermes @ 0x100: Card removed while waiting=
 for command completion.
> Oct 20 05:43:36 tardis kernel: hermes @ 0x100: Card removed while waiting=
 for command completion.
> Oct 20 05:43:36 tardis kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Oct 20 05:43:36 tardis kernel: eth0: Tx timeout! Resetting card.
> Oct 20 05:43:36 tardis kernel: hermes @ 0x100: CMD register busy in herme=
s_issue_command().
> Oct 20 05:43:36 tardis kernel: hermes @ 0x100: Frame allocation command f=
ailed (0xFFFFFFF0).
> Oct 20 05:43:36 tardis kernel: eth0: Error -16 resetting card on Tx timeo=
ut!

Dmitri

--=20
what's the difference between chattr and chmod?  SomeLamer: man chattr >
1; man chmod > 2; diff -u 1 2 | less (Seen on #linux on irc)

--=-z+DWvCJhvh2UUYYfw8XD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9uhqzXksyLpO6T4IRAlK6AJ4wAZ7kOgvHTYNrQD7lrP3RIkth8gCeJykL
abNv8uapIrwfbJkJ1lrhgyw=
=64sH
-----END PGP SIGNATURE-----

--=-z+DWvCJhvh2UUYYfw8XD--

