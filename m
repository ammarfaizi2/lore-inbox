Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbTCISwv>; Sun, 9 Mar 2003 13:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262572AbTCISwv>; Sun, 9 Mar 2003 13:52:51 -0500
Received: from h80ad255d.async.vt.edu ([128.173.37.93]:20096 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262569AbTCISwu>; Sun, 9 Mar 2003 13:52:50 -0500
Message-Id: <200303091902.h29J2eNO022051@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: "praveen R-R.No.200201004" <praveen_r@students.iiit.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unable to boot 
In-Reply-To: Your message of "Sun, 09 Mar 2003 15:17:13 +0530."
             <Pine.LNX.4.44.0303091504560.29174-100000@students.iiit.net> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0303091504560.29174-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1082647344P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Mar 2003 14:02:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1082647344P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Mar 2003 15:17:13 +0530, "praveen R-R.No.200201004" <praveen_r@students.iiit.net>  said:
>  hi,
>     when i boot  RH linux 7.2 it goes to init-2.05# prompt after the 
> message freeing kernel memory.The root partition is mounted read only and 
> none of the other partitions are mounted.Can anybody explain what is 
> happening. 

Wrong list, but I suspect your problem is either:

1) You've booted to 'single' (though other filesystems should be mounted
at this point if that were true).

2) For some reason, you booted with 'init=/bin/bash'.

3) Your root filesystem is screwed up and needs an 'fsck'.  The prompt should
look something like '(repair filesystem) #' if this is the case.

If neither of these are the case, you can either try your luck with more
details on one of the RedHat lists, or call RedHat Support if you have a
support contract....

--==_Exmh_-1082647344P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+a4/QcC3lWbTT17ARAmbJAJ96q+ewkK9hqkyqS9dNJVT/Bif5DwCgl8ot
1Aho7O2VZf7xkL6Az6jEQdo=
=mGcN
-----END PGP SIGNATURE-----

--==_Exmh_-1082647344P--
