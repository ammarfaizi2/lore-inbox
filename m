Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965400AbWJBVfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965400AbWJBVfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965417AbWJBVfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:35:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47838 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965400AbWJBVfj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:35:39 -0400
Message-Id: <200610022135.k92LZHCn008618@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] dynticks core: Fix idle time accounting
In-Reply-To: Your message of "Mon, 02 Oct 2006 23:22:38 +0200."
             <1159824158.1386.77.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu> <1159814606.1386.52.camel@localhost.localdomain> <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu>
            <1159824158.1386.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159824917_3357P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 17:35:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159824917_3357P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Oct 2006 23:22:38 +0200, Thomas Gleixner said:
> On Mon, 2006-10-02 at 16:17 -0400, Valdis.Kletnieks@vt.edu wrote:
> > cpu  27634 0 7762 20470 881 331 252 0
> > cpu0 27634 0 7762 20470 881 331 252 0
> > intr 812332 631476 2960 0 4 4 12667 3 14 1 1 4 142891 114 0 22193 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0
> > ctxt 2187603
> > btime 1159817297
> > processes 4028
> > procs_running 1
> > procs_blocked 0
> > nohz total I:397276 S:379955 T:1187.393123 A:0.003125 E: 629447
> > cpu  27753 0 7818 20739 881 332 253 0
> > cpu0 27753 0 7818 20739 881 332 253 0
> > intr 819027 636542 2969 0 4 4 12801 3 14 1 1 4 144371 114 0 22199 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0
> > ctxt 2209881
> > btime 1159817297
> > processes 4033
> > procs_running 1
> > procs_blocked 0
> > nohz total I:401991 S:384494 T:1200.732924 A:0.003122 E: 634513
> 
> Strange.
> 
> /me digs deeper

Not really strange at all - between code inspection and checking other stuff,
I'm now convinced the *counts* of "was the previous tick user/nice/system/idle"
reported in the cpu0 lines are accurate and report the relative counts
correctly.  The problem is that userspace tools are assuming that all the ticks
reported are created equal.  "We had 200 ticks, total, 100 were user and 100
were idle, so we were at 50/50 user/idle" - but in reality we had 100 10-ms
user ticks and 100 100-ms idle ticks and and only about 10% busy.....

We could "pump up" the relative counts - if 1 no-hz tick would have been 5ms
long, increment the count by 5 rather than 1 (for an alledged 1khz tick).
However, when we do that, we break the property that the sum of the ticks
in the 'cpu0' line is equal to the number of timer interrupts reported in the
'intr' line.

Like I said - unclear how to fix this....

--==_Exmh_1159824917_3357P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIYYVcC3lWbTT17ARAjxYAJkBO/1zKOuBHrRo0Mln0+Av5j9+hQCgkDHU
Ga9Di3eYL/dBuEEnrjC8/MM=
=w43D
-----END PGP SIGNATURE-----

--==_Exmh_1159824917_3357P--
