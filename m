Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTJTTXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJTTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:23:08 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:35290 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262758AbTJTTXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:23:04 -0400
Subject: [BUG] Re: 2.6.0-test8-mm1
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031020020558.16d2a776.akpm@osdl.org>
References: <20031020020558.16d2a776.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DppBFU+Hzk9ZFjPmezdF"
Message-Id: <1066677679.2121.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 21:21:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DppBFU+Hzk9ZFjPmezdF
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

The same problem with other kernel versions. I get it trying to delete
my local 2.6 svn repository:

EXT3-fs error (device hdb1): ext3_free_blocks: Freeing blocks in system
zones - Block =3D 512, count =3D 1
Aborting journal on device hdb1.
ext3_free_blocks: aborting transaction: Journal has aborted in
__ext3_journal_get_undo_access<2>EXT3-fs error (device hdb1) in
ext3_free_blocks: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in
__ext3_journal_get_write_access<2>EXT3-fs error (device hdb1) in
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdb1) in ext3_truncate: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in
__ext3_journal_get_write_access<2>EXT3-fs error (device hdb1) in
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdb1) in ext3_orphan_del: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in
__ext3_journal_get_write_access<2>EXT3-fs error (device hdb1) in
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdb1) in ext3_delete_inode: Journal has aborted
ext3_abort called.
EXT3-fs abort (device hdb1): ext3_journal_start: Detected aborted
journal
Remounting filesystem read-only
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-DppBFU+Hzk9ZFjPmezdF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/lDWuRGk68b69cdURAl2sAJ9yq6sp/IB0w8g3yE7qosvqLVUmPgCeKfWP
fMW2b5+12d2Dn4Xhko4A9zc=
=5UP+
-----END PGP SIGNATURE-----

--=-DppBFU+Hzk9ZFjPmezdF--

