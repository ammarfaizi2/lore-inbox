Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269764AbUJAMaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269764AbUJAMaZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269769AbUJAMaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:30:25 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:60632 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S269764AbUJAMaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:30:22 -0400
Date: Fri, 1 Oct 2004 14:30:19 +0200
From: Martin Waitz <tali@admingilde.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: making an in-memory hashing table ["name" -> ino_t] with thousands of entries
Message-ID: <20041001123019.GC4072@admingilde.org>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	linux-kernel@vger.kernel.org
References: <20041001120222.GA8507@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
In-Reply-To: <20041001120222.GA8507@lkcl.net>
User-Agent: Mutt/1.3.28i
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Fri, Oct 01, 2004 at 01:02:22PM +0100, Luke Kenneth Casson Leighton wrot=
e:
> bearing in mind that for every file accessed via a fuse
> filesystem, a cache entry is created, and therefore the number
> of entries could potentially run into hundreds of thousands
> of entries.

but these can be cleaned if needed.

why do you have to move all inodes into the kernel when the kernel
already cache those that are really needed?
(perhaps I'm misunderstandig fuses role here)

--=20
Martin Waitz

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBXU3aj/Eaxd/oD7IRApIMAJ4s8LUQgxFeetugJPX0xlTV0K3mdwCfV2pM
tTXrKpc7dovcQ7PGzHB17xg=
=t1L5
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
