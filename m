Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTBJBaJ>; Sun, 9 Feb 2003 20:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267497AbTBJBaJ>; Sun, 9 Feb 2003 20:30:09 -0500
Received: from mithra.wirex.com ([65.102.14.2]:14608 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S267493AbTBJBaH>;
	Sun, 9 Feb 2003 20:30:07 -0500
Message-ID: <3E4702CE.3040403@wirex.com>
Date: Sun, 09 Feb 2003 17:39:26 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <20030206151820.A11019@infradead.org> <Pine.LNX.3.96.1030207205056.31221A-100000@dixie> <20030209200626.A7704@infradead.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig0B9BC945BEE5B8FAC44569DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B9BC945BEE5B8FAC44569DB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:

>you don't get tru security by adding hooks.  security needs a careful
>design and more strict access control policy can but don't have to be part
>of that design.
>
LSM does have a careful design. The design goal was to permit loadable 
kernel modules to mediate access to critical kernel objects by user 
level processes. By providing such a facility, LSM enables arbitrary 
security policies and policy management engines to be implemented as 
loadable modules. This solves the "make one size fit all" problem of 
diverse interests lobbying Linus to adopt one security model or another 
as the Linux standard. The LSM design saves Linus from having to make 
such a  choice by allowing end-users to make their own choice, meeting a 
goal stated by Linus nearly two years ago.

>The real problem is adding mess to the kernel.
>
Christoph's problem is likely that he doesn't like the design. Fair 
enough, can't please everyone, but a lot of effort went into that 
design. I also suspect that Christoph does not approve of Linus' design 
goal either, but he's never said that when I was looking.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
			    Just say ".Nyet"


--------------enig0B9BC945BEE5B8FAC44569DB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+RwLb5ZkfjX2CNDARAcqbAKCA6jGImutCM6GKRa1Mfz+0JU/Q0gCgx+VM
p25z6ij3wV2lS21SUE+QOTI=
=chgz
-----END PGP SIGNATURE-----

--------------enig0B9BC945BEE5B8FAC44569DB--

