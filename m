Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUA2QQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUA2QQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:16:44 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:26635 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S266210AbUA2QQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:16:17 -0500
Date: Thu, 29 Jan 2004 11:16:15 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Jan Killius <jkillius@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm1: badness in try_to_wake_up
Message-ID: <20040129161615.GB2632@babylon.d2dc.net>
Mail-Followup-To: Jan Killius <jkillius@arcor.de>,
	linux-kernel@vger.kernel.org
References: <200401281558.32364.jkillius@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <200401281558.32364.jkillius@arcor.de>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2004 at 03:58:18PM +0100, Jan Killius wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi,
> I have the same problem here:
> artsd 0 waking artsd: 9105 9105
> Badness in try_to_wake_up at kernel/sched.c:722

Reverting futex-wakeup-debug.patch should do the trick.


--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

  Yes, Java is so bulletproofed that to a C programmer it feels like
being in a straightjacket, but it's a really comfy and warm
straightjacket, and the world would be a safer place if everyone was
straightjacketed most of the time.        -- Overheard in the SDM.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGTHPRFMAi+ZaeAERAqhTAJ4p2Qlf7ewlG64wBTFL/UavpH+wiACfe8c8
AhApL3h60H5m1VF0Ci9kcZc=
=VuU+
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
