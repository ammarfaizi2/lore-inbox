Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUKVOu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUKVOu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKVOlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:41:18 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:27272 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261477AbUKVOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:37:38 -0500
Date: Mon, 22 Nov 2004 15:37:20 +0100
From: Martin Waitz <tali@admingilde.org>
To: Amit Gud <amitgud1@gmail.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: file as a directory
Message-ID: <20041122143720.GL19738@admingilde.org>
Mail-Followup-To: Amit Gud <amitgud1@gmail.com>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <2c59f00304112205546349e88e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <2c59f00304112205546349e88e@mail.gmail.com>
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


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 22, 2004 at 07:24:36PM +0530, Amit Gud wrote:
>  A straight forward question. Wouldn't adding a "file as a directory"
> mechanism more logical in VFS itself, rather than having each fs (like
> reiser4) to implement it seperately?

wouldn't it be better if such things would be implemented in a library?
use gnome-vfs, or try to get a vfs layer into libc.
That way you can even support different and old kernels and all
filesystems.

The kernel already provides all methods that are neccessary to do that.
So there is no need to implement it in the kernel.

--=20
Martin Waitz

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBofmfj/Eaxd/oD7IRAi3aAJ0Vs5ghbKohVajl6rPy1vuv1EbjsQCfZHhC
O5NQdXNXEf1Dxz9g7Zbo05c=
=FdzT
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--
