Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKANvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKANvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKANvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:51:23 -0500
Received: from mail.gondor.com ([212.117.64.182]:35845 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750787AbVKANvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:51:23 -0500
Date: Tue, 1 Nov 2005 14:51:23 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption: "JBD: no valid journal superblock found"
Message-ID: <20051101135123.GB9234@knautsch.gondor.com>
References: <20051101134232.GA9234@knautsch.gondor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <20051101134232.GA9234@knautsch.gondor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 01, 2005 at 02:42:33PM +0100, Jan Niehusmann wrote:
> Currently, I'm experiencing a strange problem with one of my ext3
> filesystems: There seems to be some journal corruption, but up to now I

Well, of course I forgot one important detail: The kernel version. This
is a 2.6.14 with additional patches for CardMan 4000 support (as posted
on this list by Harald Welte), updated ipw2200 support (from
ipw2200.sourceforge.net) and btsco bluetooth headset support (from
bluetooth-alsa.sourceforge.net).

By now, I did an e2fsck which removed the ext3 journal and recovered the
ext2 without problems - unfortunately I don't have an easy way to verify
if files are corrupted, but up to now everything looks fine.

Jan


--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ2dy1oFL8fYptN/eAQLyVQP+NVIKa47Kz+Txak5H3dWPVXRlwbXp9+g3
23odv137NXU+/Rl881/5h+p8gbMztJzfm1KNVNtXI4/9WgDthT0ddMsCDOXZlf1n
ktBhdSnh8ZyeSz1t0HEW7UrPkUNKrB7fZ8VJRNuTTnkzozcffyCNEEcHIC2uLhKC
bVz0wKqq+Dg=
=CCfJ
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
