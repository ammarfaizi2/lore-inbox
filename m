Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRDMXVc>; Fri, 13 Apr 2001 19:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132398AbRDMXVW>; Fri, 13 Apr 2001 19:21:22 -0400
Received: from shuzbut.anathoth.gen.nz ([202.36.174.50]:1800 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S132385AbRDMXVQ>; Fri, 13 Apr 2001 19:21:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD Writing!!!! 
In-Reply-To: Your message of "Fri, 13 Apr 2001 14:08:04 +0100."
             <E14o3J0-0002q2-00@the-village.bc.nu> 
In-Reply-To: <E14o3J0-0002q2-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1095893704P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Apr 2001 11:20:44 +1200
From: Matthew Grant <grantma@anathoth.gen.nz>
Message-Id: <E14oCrt-0002ga-00@zion.int.anathoth.gen.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1095893704P
Content-Type: text/plain; charset=us-ascii


Very glad to see that the SYMBIOS driver changes in 2.4.3-ac5 has solved all 
of my SCSI woes...

> > Running LVM 0.9.1beta7 (kernel patch) with Reiserfs v2, + Reiserfs VFS patch 
> > (this works!!!! - go put it in Alan!!! - its in the LVM tar ball).
> 
> LVM - no. The LVM patch is a disgusting pile of crud right now

Their patch generation is CRAP!@#$!@#%#, but I find that LVM 0.9.1beta2 in the 
kernel is more broken than beta7  version, a lot of lvm operations in the 
kernel version DON'T WORK!!!

What are the problems????

Just had a quick looksee at their patch - you should be able to get a better 
diff by applying their patch to a kernel tree and then doing a diff -w to 
regenerate it...  ???

The VFS stuff they have done - seemed like a small change to me, and it is a 
seperate patch.

Reiserfs quota support should be added to the kernel if it is simple also.  
Reiserfs knfsd functionality looks like a real nightmare, and if people want 
to NFS share a reiserfs file system, for the moment they can just go and use 
the old Userspace NFS server...

Distributions are all going to be pushing for this, they will all want to use 
reiserfs on LVM and RAID sub-systems with quota support.  The kernel NEEDS to 
have reiserfs better intergrated into its subsystems.  We have to get it all 
cleaned up and get it out there.  If you are iffy about one of these features, 
put it in as an (EXPERIMENTAL) configuration item - We need to get them out 
there rather than having a lot of different ongoing backroom operations to add 
the functionality.


Best Regards,

Matthew Grant
-- 
===============================================================================
Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz  It's/~~~~\Plain where
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\I come from
===============================================================================



--==_Exmh_1095893704P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.2 06/23/2000 (debian 2.2-1)

iD8DBQE614nMuk55Di7iAnARAilqAJ4iTJToFqj8J5tvwwG6VozD63Gq6gCdFXZx
noC/xIzXytmTt6pKFRQ+wb4=
=DycU
-----END PGP SIGNATURE-----

--==_Exmh_1095893704P--
