Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264709AbUENG3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbUENG3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 02:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUENG3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 02:29:11 -0400
Received: from darwin.snarc.org ([81.56.210.228]:5250 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S264316AbUENG3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 02:29:03 -0400
Date: Fri, 14 May 2004 08:28:55 +0200
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove hardcoded offsets from i386 asm
Message-ID: <20040514062855.GA8842@snarc.org>
References: <40A4318A.2050504@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <40A4318A.2050504@quark.didntduck.org>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 10:40:10PM -0400, Brian Gerst wrote:
> Generate offsets for thread_info, cpuinfo_x86, and a few others instead=
=20
> of hardcoding them.

Hi Brian,

why not keeping all macro name in uppercase ?

the patch would look a lot smaller, and as the macro got the same
meaning, I don't see why the name should change.

> -	movl TI_FLAGS(%ebp), %ecx
> +	movl TI_flags(%ebp), %ecx

Cheers,
--=20
Tab

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFApGcnzKe/MInoaQARAncLAJ9/pI3uqkKcQmIP/pUR5LPrlhs6mQCggvyC
U0WHd4C1bzal9KZH3KeVcY4=
=Mkfg
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
