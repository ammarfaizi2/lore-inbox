Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUEQXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUEQXSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEQXSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:18:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23528 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263121AbUEQXSk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:18:40 -0400
Message-Id: <200405172318.i4HNIb0V004180@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug 
In-Reply-To: Your message of "Tue, 18 May 2004 01:02:04 +0200."
             <Pine.LNX.4.44.0405180049040.20775-100000@hubble.stokkie.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0405180049040.20775-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1043335254P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 May 2004 19:18:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1043335254P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 May 2004 01:02:04 +0200, "Robert M. Stockmann" <stock@stokkie.net>  said:
> Hi,
> 
> I have severe problems creating a new root-disk using the ramdisk driver
> of kernel 2.6.6 :

> [tapebox:root]:(/mnt/floppy)# cp -ap bin boot cdrom dev etc floppy lib mnt proc root sbin tag tmp usr var /mnt/root

Were you expecting those to copy all the contents, or just the directories themselves?

Perhaps   tar cf - | (cd /mnt/root && tar xvf -)
or adding a -r flag to that cp?  

> So basicly i copied all my files from rootmdk92 to the new rootmdk100 ramdisk

No, I think you just copied the directories..

> But after copying them and umounting the old ramdisk (rootmdk92) en deleting
>  /dev/loop0 , /dev/loop1 (which is /tmp/rootmdk100) loses all its contents.

It never had the contents to lose.....

--==_Exmh_-1043335254P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAqUhNcC3lWbTT17ARAtxjAKCVXhpB9Lbj71qT3lYs7o55v+2ZnQCg5w0L
MmO3ID8CAyqbv18oqcMczIs=
=x3IU
-----END PGP SIGNATURE-----

--==_Exmh_-1043335254P--
