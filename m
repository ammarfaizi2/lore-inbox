Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbTF3RXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTF3RXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:23:35 -0400
Received: from h80ad2713.async.vt.edu ([128.173.39.19]:42894 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265526AbTF3RXe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:23:34 -0400
Message-Id: <200306301737.h5UHblNS029187@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Leonard Milcin Jr." <thervoy@post.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas 
In-Reply-To: Your message of "Mon, 30 Jun 2003 18:59:34 +0200."
             <3F006C76.7010308@post.pl> 
From: Valdis.Kletnieks@vt.edu
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net> <bdpn3c$te5$1@tangens.hometree.net>
            <3F006C76.7010308@post.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1960887946P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jun 2003 13:37:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1960887946P
Content-Type: text/plain; charset=us-ascii

On Mon, 30 Jun 2003 18:59:34 +0200, "Leonard Milcin Jr." <thervoy@post.pl>  said:

> Hey folk! I don't used LVM, but I think it allows file to be splitted 
> between diferent filesystems. Yes?

No.

LVM lets you "glue together" multiple partitions/disks/parts of disks to make ONE filesystem.

There's no way to say "Gig 1 throughj 3 of this file is in /fs1/foo and Gigs 4 and 5 are in /fs2/bar".

For starters, what happens if the permissions on foo and bar are different? ;)


--==_Exmh_-1960887946P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/AHVqcC3lWbTT17ARAtm5AJsFC0XUw8C4V07XrJio2m3gi7cm1QCg/iCw
4XbQghmIHDU0zK03FNneWF8=
=gN6/
-----END PGP SIGNATURE-----

--==_Exmh_-1960887946P--
