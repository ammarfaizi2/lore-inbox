Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTBKEIr>; Mon, 10 Feb 2003 23:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTBKEIr>; Mon, 10 Feb 2003 23:08:47 -0500
Received: from h80ad257a.async.vt.edu ([128.173.37.122]:43136 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265895AbTBKEIp>; Mon, 10 Feb 2003 23:08:45 -0500
Message-Id: <200302110418.h1B4I5jB002548@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@digeo.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: extra PG_* bits for page->flags 
In-Reply-To: Your message of "Mon, 10 Feb 2003 15:12:44 PST."
             <20030210151244.7e42d3fb.akpm@digeo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20459.1044874267@warthog.cambridge.redhat.com>
            <20030210151244.7e42d3fb.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-990762870P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Feb 2003 23:18:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-990762870P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Feb 2003 15:12:44 PST, Andrew Morton said:

> Is a new fs needed?  Is it not possible to use an existing filesystem of the
> user's choice for local caching?

It's sort of like a loopback mount - you need a backing store which could be
on an ext3 or ramfs or whatever, and you need the user-visible front end side
of things, which manages the backing store and fetches blocks from AFS/NFS/etc.

--==_Exmh_-990762870P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+SHl9cC3lWbTT17ARAsFCAJ4wS3WWn+s95pZp8Zv3XZGuiU1qrQCfTJjo
EK0R5mZHGleMjtd7sfDB/HQ=
=EE9j
-----END PGP SIGNATURE-----

--==_Exmh_-990762870P--
