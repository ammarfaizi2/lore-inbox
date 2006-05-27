Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWE0K2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWE0K2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 06:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWE0K2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 06:28:08 -0400
Received: from admingilde.org ([213.95.32.146]:56741 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751424AbWE0K2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 06:28:07 -0400
Date: Sat, 27 May 2006 12:28:05 +0200
From: Martin Waitz <tali@admingilde.org>
To: Paul Drynoff <pauldrynoff@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Message-ID: <20060527102804.GD14325@admingilde.org>
Mail-Followup-To: Paul Drynoff <pauldrynoff@gmail.com>,
	linux-kernel@vger.kernel.org
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com> <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com> <36e6b2150605260058h5c1fbc0cla686a37d5bf3e34e@mail.gmail.com> <Pine.LNX.4.58.0605261059360.30386@sbz-30.cs.Helsinki.FI> <36e6b2150605260120s2fb692fegf4fef1eecf7c4674@mail.gmail.com> <9a8748490605260248i68a1eb84hc241068ae1f012bb@mail.gmail.com> <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <36e6b2150605260344l1ba91d56we2d224d49bde4d8e@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

thank you for your work!

unfortunately gmail seems to have corrupted your patch slightly
(single spaces on it's own line are stripped).

On Fri, May 26, 2006 at 02:44:08PM +0400, Paul Drynoff wrote:
> +/**
> + * kmalloc - allocate memory
> + * @size: how many bytes of memory are required.
> + * @gfp: the type of memory to allocate.

this should be @flags

> + * kmalloc is the normal method of allocating memory
> + * in the kernel.
> + *
> + * The @gfp argument may be one of:
> + *
> + * %GFP_USER - Allocate memory on behalf of user.  May sleep.
> + *
> + * %GFP_KERNEL - Allocate normal kernel ram.  May sleep.
> + *
> + * %GFP_ATOMIC - Allocation will not sleep.  Use inside interrupt handle=
rs.
> + * %GFP_HIGHUSER - Allocate pages from high memory.
> + * %GFP_NOIO - Do not do any I/O at all while trying to get memory.
> + * %GFP_NOFS - Do not make any fs calls while trying to get memory.

please add newlines here, too.

> + * Also it is possible set different flags by OR'ing
> + * in one or more of the following:
> + * %__GFP_COLD
> + *  - Request cache-cold pages instead of trying to return cache-warm=20
> pages.
> + * %__GFP_DMA
> + *  - Request memory from the DMA-capable zone
> + * %__GFP_HIGH
> + *  - This allocation is high priority and may use emergency pools.
> + * %__GFP_HIGHMEM
> + *   - Allocated memory may be from highmem.
> + * %__GFP_NOFAIL
> + *  - Indicate that this allocation is in no way allowed to fail
> + * (think twice before using).
> + * %__GFP_NORETRY
> + * - If memory is not imidiately available, then give up at once.
> + * %__GFP_NOWARN
> + * - If allocation fails, don't issue any warnings.
> + * %__GFP_REPEAT
> + * - If allocation fails initially, try once more before failing.

and here, too.

--=20
Martin Waitz

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEeCm0j/Eaxd/oD7IRAmq/AJ9uO4fID0jPBZh+HXMumkLQ/j0EkgCfWgxm
a3y+tURvH9/zDUO5u+iNMV0=
=9uk3
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
