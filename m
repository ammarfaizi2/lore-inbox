Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbUKRSXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUKRSXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUKRSV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:21:29 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:58050 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262838AbUKRSBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:01:37 -0500
Subject: Re: local packets not in prerouting
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0411181729350.12660@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411181729350.12660@yvahk01.tjqt.qr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-weAwhoLL0GtxXRMecYtO"
Message-Id: <1100800891.20185.59.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Nov 2004 19:01:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-weAwhoLL0GtxXRMecYtO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-11-18 at 17:37, Jan Engelhardt wrote:
> Hi,

Hi

> I have been observing that locally generated packets with a local destina=
tion
> have they don't pop up in the nat/PREROUTING chain.
> Anybody know why this is done? (If not, it's a bug.)

It's not a bug. All locally generated packets go through nat/OUTPUT ,
not nat/PREROUTING.

--=20
/Martin

--=-weAwhoLL0GtxXRMecYtO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBnON7Wm2vlfa207ERAiFDAJ97tVd401TixL7kSsfxHpW54QKzawCfa/aE
St52jyd1mapNuyZz6uGbvsw=
=ebn0
-----END PGP SIGNATURE-----

--=-weAwhoLL0GtxXRMecYtO--
