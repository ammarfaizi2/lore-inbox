Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUAPQVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUAPQVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:21:38 -0500
Received: from h80ad2659.async.vt.edu ([128.173.38.89]:37504 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265598AbUAPQVg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:21:36 -0500
Message-Id: <200401161620.i0GGK2MT022923@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Vladimir Saveliev <vs@namesys.com>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item returned -28 
In-Reply-To: Your message of "Fri, 16 Jan 2004 11:17:43 +0300."
             <1074241063.2251.41.camel@tribesman.namesys.com> 
From: Valdis.Kletnieks@vt.edu
References: <200401091622.41352.lkml@kcore.org>
            <1074241063.2251.41.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1102226752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jan 2004 11:19:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1102226752P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Jan 2004 11:17:43 +0300, Vladimir Saveliev said:

> This is just a warning. You should be able to free some disk space by
> removing some files.

Is this just the *obvious* "removing files frees space", or is there some sort
of garbage collection that will be triggered, so removing a 1K file will make it
redo tables/linked lists/whatever and return lots of blocks that used to contain
metadata?

--==_Exmh_-1102226752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFACA8XcC3lWbTT17ARAhaVAJ4onS9kKbySzuveEDM3l98KeI0kawCg5DpO
S+A+4NQPzC+wcq2XXuTvrZk=
=duJP
-----END PGP SIGNATURE-----

--==_Exmh_-1102226752P--
