Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbULPHmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbULPHmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbULPHmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:42:00 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:30427 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262631AbULPHlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:41:47 -0500
Date: Thu, 16 Dec 2004 08:41:41 +0100
From: Martin Waitz <tali@admingilde.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sockets from kernel space?
Message-ID: <20041216074140.GJ31835@admingilde.org>
Mail-Followup-To: John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <41C0E720.8050201@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <41C0E720.8050201@comcast.net>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 15, 2004 at 08:38:40PM -0500, John Richard Moser wrote:
> Is it possible to create socket connections (AF_UNIX for example) from
> the kernel to local user processes that are listen()ing?

AF_NETLINK is made for exactly that purpose.

look at linux/netlink.h and net/ipv4/netfilter/ipt_ULOG.c for example code.

--=20
Martin Waitz

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBwTw0j/Eaxd/oD7IRArEuAJ40EFVrEp+8s+aCgJvjubL+vwVlLwCfZkvY
iAvqsQXmExzVpoOxK4CNNuU=
=7FkS
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--
