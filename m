Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUGIJpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUGIJpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 05:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUGIJpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 05:45:05 -0400
Received: from mout0.freenet.de ([194.97.50.131]:57005 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S264584AbUGIJoy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 05:44:54 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: GCC 3.4 and broken inlining.
Date: Fri, 9 Jul 2004 11:43:30 +0200
User-Agent: KMail/1.6.2
References: <2fFzK-3Zz-23@gated-at.bofh.it> <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au> <20040709054657.GA52213@muc.de>
In-Reply-To: <20040709054657.GA52213@muc.de>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407091143.41955.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Andi Kleen <ak@muc.de>:
> It's too bad that i386 doesn't enable -funit-at-a-time, that improves
> the inlining heuristics greatly.

- From the gcc manpage:

- -O2 turns on all optimization flags specified by -O. It 
also turns on the following optimization flags: -fforce-mem 
- -foptimize-sibling-calls -fstrength-reduce -fcse-follow-jumps 
- -fcse-skip-blocks -frerun-cse-after-loop -frerun-loop-opt 
- -fgcse -fgcse-lm -fgcse-sm -fgcse-las -fdelete-null-pointer-checks 
- -fexpensive-optimizations -fregmove -fschedule-insns 
- -fschedule-insns2 -fsched-interblock -fsched-spec -fcaller-saves 
- -fpeephole2 -freorder-blocks -freorder-functions -fstrict-aliasing 
- -funit-at-a-time -falign-functions -falign-jumps -falign-loops 
^^^^^^^^^^^^^^^^
- -falign-labels -fcrossjumping 

Do I miss something?

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7mjJFGK1OIvVOP4RAuXyAJ0fM5x1jqCZGkzO2jfl42CaNLgJJwCdGZQW
3rUgM3svqyWb8JaCavWAkhg=
=3LeQ
-----END PGP SIGNATURE-----
