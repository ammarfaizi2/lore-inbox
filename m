Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTFANYu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTFANYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:24:50 -0400
Received: from blackham.com.au ([203.59.54.161]:19216 "EHLO
	dagobah.blackham.com.au") by vger.kernel.org with ESMTP
	id S264592AbTFANYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:24:49 -0400
Date: Sun, 1 Jun 2003 21:38:04 +0800
From: Bernard Blackham <b-lkml@blackham.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] VFS mapping table
Message-ID: <20030601133804.GA4131@amidala>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Organization: Dagobah Systems
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Whilst setting up a bunch of thin clients, I thought it'd be really
useful if a symlink could be pointed at, say /mnt/{ip}/hostname and
{ip} would expand to the IP address of the machine (inspired by
Tru64 unix).

It was subsequently realised that this could have other uses, so
here is a patch, against 2.4.20 (applies against 2.4.21-rc6 too)
that allows you to expand {keyword} to something customisable
through /proc. For usage details, see the comments at the top of
fs/vfs_map.c

Patch at http://dagobah.ucc.asn.au/linux-2.4.20-vfsmap.diff
68dd58872ec33cfb4ce34306b712a8f4  linux-2.4.20-vfsmap.diff

So does anybody think this would be a useful feature to have, or
just feature bloat? If useful, I'd be happy to port it to 2.5.xx.

Ta,
Bernard.
PS. please CC me on replies.

--=20
 Bernard Blackham=20
 bernard at blackham dot com dot au

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+2gG8ccTsdj5FJ6QRArOUAKCbe9+aq8b6TyLputBgEorWwn/ZYQCgivAj
bO/OG/IED1SNBYzvugbOYJc=
=1JLS
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
