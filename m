Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbTJYE47 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 00:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTJYE47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 00:56:59 -0400
Received: from h80ad2674.async.vt.edu ([128.173.38.116]:24969 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262404AbTJYE46 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 00:56:58 -0400
Message-Id: <200310250456.h9P4ufdp009300@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk 
In-Reply-To: Your message of "Sat, 25 Oct 2003 04:28:03 +0200."
             <20031025022803.GA18168@DUK2.13thfloor.at> 
From: Valdis.Kletnieks@vt.edu
References: <20031014104508.GA5820@win.tue.nl> <20031014133804.GC15295@iguana.domsch.com>
            <20031025022803.GA18168@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_93061032P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Oct 2003 00:56:41 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_93061032P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Oct 2003 04:28:03 +0200, Herbert Poetzl said:

> hmm, IIRC devfs makes a /dev/root symlink pointing
> to the root device ... is this not what you want?

No, he wants a pointer to the disk that has the boot block and
all that - the disk that grub/lilo and /boot are on (which could be
two separate disks I suppose) may not be the disk that / lives on....

--==_Exmh_93061032P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/mgKIcC3lWbTT17ARAr4CAKD0cO8wZ2O22Dao0cj1gKzGumTaKwCaA9OM
BjDdA90uzZWSpZ5/FK5h6BI=
=UDLX
-----END PGP SIGNATURE-----

--==_Exmh_93061032P--
