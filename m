Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUAAMLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUAAMLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:11:15 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:14213 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261500AbUAAMLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:11:13 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1072958618.1603.236.camel@thor.asgaard.local>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+BQMTrUkAZXBNj3s31oX"
Organization: Red Hat, Inc.
Message-Id: <1072959055.5717.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jan 2004 13:10:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+BQMTrUkAZXBNj3s31oX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 13:03, Michel D=C3=A4nzer wrote:

> How does this patch look?

ugly.

I find using #defines for function arguments ugly beyond belief and
makes it really hard to look through code. I 10x rather have an ifdef in
the function prototype (which then for the mainstream kernel drm can be
removed for non-matching versions) than such obfuscation.


--=-+BQMTrUkAZXBNj3s31oX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/9A5PxULwo51rQBIRAqMOAJ9N3jOxX5ZAw/r0mLHMP/fBERYXLACfV1u0
H27CgprSQEhJT6DyYjs5qUQ=
=g6UZ
-----END PGP SIGNATURE-----

--=-+BQMTrUkAZXBNj3s31oX--
