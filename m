Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVADIto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVADIto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 03:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVADIto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 03:49:44 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:46824 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261563AbVADIt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 03:49:28 -0500
Date: Tue, 4 Jan 2005 09:49:08 +0100
From: Martin Waitz <tali@admingilde.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] cachefs: possible cleanups
Message-ID: <20050104084907.GA10016@admingilde.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20050103235340.GS2980@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20050103235340.GS2980@stusta.de>
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


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Jan 04, 2005 at 12:53:40AM +0100, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - misc.c: #if 0 the unused global function __cachefs_page_get_private

it looks like this function should be removed, it is a duplicate of
__fscache_page_get_private in fs/fscache/page.c (from before the fscache sp=
lit)

--=20
Martin Waitz

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB2liDj/Eaxd/oD7IRAhHRAJ0UzYXPm8Q3Gry5tBjMFuiUcJDHSQCfUjv8
DdwhcnpFwpHOJqxf2tzLkbQ=
=2P+J
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
