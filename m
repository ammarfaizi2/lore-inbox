Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUBPD6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUBPD6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:58:39 -0500
Received: from h80ad24fd.async.vt.edu ([128.173.36.253]:35478 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265351AbUBPD6i (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:58:38 -0500
Message-Id: <200402160358.i1G3wC6W013389@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chip Salzenberg <chip@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30 
In-Reply-To: Your message of "Sun, 15 Feb 2004 22:47:37 EST."
             <40303D59.4030605@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com>
            <40303D59.4030605@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1198498653P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Feb 2004 22:58:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1198498653P
Content-Type: text/plain; charset=us-ascii

On Sun, 15 Feb 2004 22:47:37 EST, Jeff Garzik said:
> One for the todo list, I suppose...  a useable workaround for this is 
> probably good ole 'e2fsck -c', i.e. badblocks...  That says "check again 
> to see if this sector is bad", and -hopefully- will unmark bad blocks 
> that were incorrectly marked bad.

Does e2fsck/badblocks issue the right ioctls/etc to make the disk read the
*original* block, or will the disk simply check the *redirected* block?

--==_Exmh_1198498653P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMD/TcC3lWbTT17ARAjS8AJ9MqwKfxZYd1aZJo4cjn8DQcKTKbQCdGrO9
XaacG20aQPRxXJR/Y1WlIm0=
=SdjD
-----END PGP SIGNATURE-----

--==_Exmh_1198498653P--
