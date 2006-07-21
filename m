Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWGUU23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWGUU23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWGUU23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:28:29 -0400
Received: from dilbert.robsims.com ([209.120.158.98]:20497 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S1751138AbWGUU22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:28:28 -0400
Date: Fri, 21 Jul 2006 14:28:25 -0600
From: Rob Sims <lkml-z@robsims.com>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links
Message-ID: <20060721202825.GB29656@robsims.com>
References: <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2006 at 06:04:49PM -0700, Joshua Hudson wrote:
> This patch is the sum total of all that I had to change in the kernel
> VFS layer to support hard links to directories and a few worse things
> (hard links to things that are sometimes directories). Never mind
> about do_path_lookup. I call that from an ioctl (flink).
=20
What is the parent of a hard linked directory?  What is the parent if
the link in "the parent" is deleted?
--=20
Rob
  A man is known by the company he organizes.
  		-- Ambrose Bierce

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEwTjpnvKppSZW8osRAtjDAJ958L5Zcj4svLUGtKrXvpHbb0h45wCdHs/b
MQ6icIjkPFfIHVmAmIpb9Mg=
=Jlyo
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

