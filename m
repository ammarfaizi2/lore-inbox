Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319629AbSIMN0n>; Fri, 13 Sep 2002 09:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319630AbSIMN0n>; Fri, 13 Sep 2002 09:26:43 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22788 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319629AbSIMN0m>; Fri, 13 Sep 2002 09:26:42 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15745.59564.28543.921212@laputa.namesys.com>
Date: Fri, 13 Sep 2002 17:31:24 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [reiserfs-dev] Re: UML 2.5.34 
In-Reply-To: <200209131429.JAA02083@ccure.karaya.com>
References: <15745.48975.172938.121684@laputa.namesys.com>
	<200209131429.JAA02083@ccure.karaya.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Windows: you'd better sit down.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike writes:
 > Nikita@Namesys.COM said:
 > > And this is a patch to make it compilable (not sure about
 > > CLOCK_TICK_RATE and pte_addr_t parts though): 
 > 

pte_addr_t and CLOCK_TICK_RATE were undefined.

Wrong macro in include/asm-um/percpu.h resulted in
include/asm-um/cacheflush.h never being included and a macros from the
latter undefined also.

By the way, I am talking about Linus BK tree, rather than patches you
have posted. Sorry for not mentioning this from the beginning.

 > Where did you get compilation problems?  It compiled for me fine.
 > 
 > 				Jeff

Nikita.
