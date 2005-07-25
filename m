Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVGYUEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGYUEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGYUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:04:10 -0400
Received: from h80ad251a.async.vt.edu ([128.173.37.26]:135 "EHLO
	h80ad251a.async.vt.edu") by vger.kernel.org with ESMTP
	id S261503AbVGYUDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:03:52 -0400
Message-Id: <200507252003.j6PK3bcS022382@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andreas Baer <lnx1@gmx.net>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood- 
In-Reply-To: Your message of "Mon, 25 Jul 2005 21:51:49 +0200."
             <42E542D5.3080905@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local>
            <42E542D5.3080905@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122321816_2774P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Jul 2005 16:03:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1122321816_2774P
Content-Type: text/plain; charset=us-ascii

On Mon, 25 Jul 2005 21:51:49 +0200, Andreas Baer said:

> > a reason for what ? the fact that the notebook performs faster than the
> > desktop while slower on I/O ?
> 
> No, a reason why the partition with Linux (ReiserFS or Ext3) is always slower
> than the Windows partition?

My first guess is that ReiserFS and EXT3 are journalled, and FAT32 isn't.
Try ext2, which is the non-journalled variant of ext3, and see if the speed
is comparable to fat32.

--==_Exmh_1122321816_2774P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5UWYcC3lWbTT17ARApvwAKDNO7cYe+vPs2xR1DEFULDWLVOgbACgwORU
vfhkwFSpvnBx2vKvR5ls8Ss=
=mlgz
-----END PGP SIGNATURE-----

--==_Exmh_1122321816_2774P--
