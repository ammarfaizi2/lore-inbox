Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132429AbRDNADA>; Fri, 13 Apr 2001 20:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDNACv>; Fri, 13 Apr 2001 20:02:51 -0400
Received: from shuzbut.anathoth.gen.nz ([202.36.174.50]:4872 "EHLO
	shuzbut.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id <S132429AbRDNACo>; Fri, 13 Apr 2001 20:02:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 (debian 2.2-1) with nmh-1.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: grantma@anathoth.gen.nz (Matthew Grant), linux-kernel@vger.kernel.org
Subject: Re: New SYM53C8XX driver in 2.4.3-ac5 FIXES CD Writing!!!! 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Sat, 14 Apr 2001 00:44:54 +0100." <E14oDFI-0003or-00@the-village.bc.nu> 
In-Reply-To: <E14oDFI-0003or-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156241554P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Apr 2001 12:02:19 +1200
From: Matthew Grant <grantma@anathoth.gen.nz>
Message-Id: <E14oDW7-0002y9-00@zion.int.anathoth.gen.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156241554P
Content-Type: text/plain; charset=us-ascii

> > 
> > A core kernel developer  NEEDS to get these features straightened out properly 
> > in a clean fashion.  People WANT reiserfs integrated and working with LVM and 
> 
> Note _clean_

I agree completely.

> 
> > It does not look like that much work is needed to fix the stuff the base kernel
> > and get better integration of these features.  The rough edges on them make us 
> > look like a bunch of amatuers.
> 
> Lots of work needs doing. The entire quota code needs rewriting and that won't
> happen until 2.5. The reiser+nfs stuff is probably also 2.5

Sounds like we need a 2.6 fairly soon after a 2.5 rather than going on a 
complete development voyage around the world every 18 months...

Linus,

Can't we have a controlled  development tree branch for 2-3 months just to get 
the ReiserFS/LVM/quota/knfsd integration done _cleanly_ (this has significant 
short-term  benefits NOW), with the brakes on all other changes, and another 
development tree where everyone goes wild with NUMA/Networking et al., where 
the changes from the other get merged???

> 
> > Alan, will you look into it as a project???
> 
> Not interested. Now is stabilizing time, not stuffing crap into the kernel tree
> time. Vendors can (and will) ship stuff which is workable but not clean, and
> they will hopefully over time fix up the stuff they care about and submit it.

Any takers to look at re-bending the current LVM fixes, + the reiserFS 
snapshot stuff???.  From what I can gather people will ALWAYS be applying the 
pathes for this to the stock kernel source.

> 
> Alan
> 

-- 
===============================================================================
Matthew Grant	     /\	 ^/\^	grantma@anathoth.gen.nz  It's/~~~~\Plain where
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\I come from
===============================================================================



--==_Exmh_1156241554P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.2 06/23/2000 (debian 2.2-1)

iD8DBQE615OLuk55Di7iAnARAlEhAJwM8Dae3X4ZQJTYS42poBD2Iy90IwCdHek2
Y8cJ/njgNrTyzyPPjGr8FKY=
=xKrg
-----END PGP SIGNATURE-----

--==_Exmh_1156241554P--
