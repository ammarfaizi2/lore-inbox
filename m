Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWFIClE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWFIClE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWFIClE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:41:04 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:54725
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965066AbWFIClB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:41:01 -0400
Message-Id: <200606090240.k592enXj009395@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
In-Reply-To: Your message of "Thu, 08 Jun 2006 18:20:54 PDT."
             <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149820848_9032P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jun 2006 22:40:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149820848_9032P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Jun 2006 18:20:54 PDT, Mingming Cao said:
> Current ext3 filesystem is limited to 8TB(4k block size), this is
> practically not enough for the increasing need of bigger storage as
> disks in a few years (or even now).
> 
> To address this need, there are co-effort from RedHat, ClusterFS, IBM
> and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
> expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
> ext3 is build on top of extent map changes for ext3, originally from
> Alex Tomas. In short, the new ext3 on-disk extents format is:

which implies matching changes to mkfs.ext2 and possibly mount..

> Appreciate any comments and feedbacks!

Somebody else was recently discussing a set of patches to ext3 for
extents+delalloc+mballoc patches - is this work compatible with that?

Also, a pointer to the matching userspace patches would help anybody
who's gung-ho enough to test the code....


--==_Exmh_1149820848_9032P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEiN+wcC3lWbTT17ARArxRAJ9VnUATRvE3otfqd+kyLOGUvQYLfwCg0ml7
gsBWFuOKlnCS85noL6W7Rr0=
=Zosa
-----END PGP SIGNATURE-----

--==_Exmh_1149820848_9032P--
