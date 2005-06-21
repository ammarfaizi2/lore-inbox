Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVFUJDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVFUJDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVFUI7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:59:39 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:6050 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262078AbVFUI6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:58:06 -0400
Date: Tue, 21 Jun 2005 10:57:41 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <christoph@lameter.com>, jgarzik@pobox.com,
       telendiz@eircom.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement in /fs/open.c
Message-ID: <20050621085740.GK11059@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Lameter <christoph@lameter.com>, jgarzik@pobox.com,
	telendiz@eircom.net, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain> <42B70E62.5070704@pobox.com> <Pine.LNX.4.62.0506201154300.2245@graphe.net> <20050620133800.0dac1d97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <20050620133800.0dac1d97.akpm@osdl.org>
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
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jun 20, 2005 at 01:38:00PM -0700, Andrew Morton wrote:
> Yes, it is cleaner that way.

Well, I don't think so...

> The old trick to make the error-handling code out-of-line shouldn't be
> needed nowadays - IS_ERR uses unlikely(), which is supposed to handle that
> stuff.

IMHO out-of-line error handling improves readability because you have a
clear boundary between real functionality and error handling.  If both
are mixed up you have to look longer at the code to understand the
control-flow.

--=20
Martin Waitz

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCt9aEj/Eaxd/oD7IRAgoQAJ4kZHHH0yDdbmPwFJA3TNjOI6wBOwCeJlTJ
X2Mlh1qQWKdDp73qtMdGTrk=
=GXwK
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
