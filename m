Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316863AbSE3U7b>; Thu, 30 May 2002 16:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316864AbSE3U7a>; Thu, 30 May 2002 16:59:30 -0400
Received: from stingr.net ([212.193.32.15]:54912 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S316863AbSE3U7a>;
	Thu, 30 May 2002 16:59:30 -0400
Date: Fri, 31 May 2002 00:59:29 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] 2.4.19-pre9-ac1-s1
Message-ID: <20020530205929.GD355@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Here goes 2.4.19-pre9-ac1-s1.

I am have kbuild-2.5 in here too. So make -f Makefile-2.5 :)

Changes from kbuildified 2.4.19-pre9-ac1:
*	Netfilter hooks for ethernet bridging	(Lennert)
*	MTU problem fixes for eepro100, tulip,	(?)
	and 3c59x
*	Zerocopy path for netfilter		(?)
*	Alternate conntrack hash function &	(me)
	hash table sizing policy
*	task_t.state cleanups			(me)
*	/dev/epoll				(Davide Libenzi)
*	Reiserfs quotas				(?)
*	smbfs large file support		(Urban Widmark)
*	irqrate					(Ingo)
*	Some hashes (yes they shouldn't be	(wli)
	here)
*	Some reiserfs fixes			(Chris Mason & namesys)
*	bkl_rollup				(Dave Hansen)
*	e100 & e1000 2.4 backports		(Intel, J.A.Magallon)
*	bridging code fixes			(Lennert)
*	EVMS 1.0.1				(EVMS team)
	with crap needed for O(1) sched		(me)
*	fast_walkA3-2.4.19-pre8 merge		(Hanna Linder, Al Viro)
*	Huge collection of netfilter P-O-M	(Netfilter team)
	patches applied with small quickfixes
	from mine
*	-aa bits, some of them merged to	(Andrea Archangeli)
	nothing, some remains
*	kbuild 2.5 makefiles for all above	(me)

Full, unformatted bk changelog available here:
http://stingr.net/l/ChangeLog-bk-2.4.19-pre9-ac1-s1.bz2
ftp://stingr.net/pub/l/ChangeLog-bk-2.4.19-pre9-ac1-s1.bz2

It should apply on top of plain 2.4.19-pre9-ac1. You can grab it here:
http://stingr.net/l/patch-2.4.19-pre9-ac1-s1.bz2
ftp://stingr.net/pub/l/patch-2.4.19-pre9-ac1-s1.bz2

Remember - you have to get patches to samba to make it actually work 
with large files.

Enjoy.
- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjz2kpQACgkQyMW8naS07KR3uQCeIdQdRRUNC6T9xfMRXNfpZdQ9
OcsAoIzfbA67aJUI0+LlBZOj2k515HOV
=KMvE
-----END PGP SIGNATURE-----
