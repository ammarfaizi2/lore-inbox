Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270533AbTGND5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270525AbTGND5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:57:01 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:4251 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S270533AbTGND4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:56:43 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.11602.69012.914766@wombat.chubb.wattle.id.au>
Date: Mon, 14 Jul 2003 14:10:58 +1000
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Mikael Pettersson <mikpe@csd.uu.se>, axboe@suse.de, bernie@develer.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
In-Reply-To: <3F0F5E44.1080109@cyberone.com.au>
References: <200307112048.h6BKmUQj003987@harpo.it.uu.se>
	<20030711140158.0b27117e.akpm@osdl.org>
	<16143.23320.180064.599815@cargo.ozlabs.ibm.com>
	<3F0F5E44.1080109@cyberone.com.au>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> 1. For some reason the LBD config option in drivers/block/Kconfig
>> depends on X86.  (CONFIG_LBD is what makes sector_t an unsigned
>> long long instead of an unsigned long).  I think the LBD option
>> should be available on all 32-bit platforms.  Working out a neat
>> way to tell the config system that is left as an exercise for the
>> reader. :)
>> 

Nick> Not me :P

No 'twas me --- because I couldn't work oput any cvlean way to do it,
and, of the 32-bit plaftforms, I could test only x86.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
