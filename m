Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272284AbTHDXGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272286AbTHDXGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:06:31 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:22430
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S272284AbTHDXGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:06:24 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16174.59114.386209.649300@wombat.chubb.wattle.id.au>
Date: Tue, 5 Aug 2003 09:06:18 +1000
To: davidm@hpl.hp.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: milstone reached: ia64 linux builds out of Linus' tree
In-Reply-To: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

David> Now that Linus' tree works for ia64, the next question is how
David> we can keep it that way.  I think it would be useful to have
David> someone setup a cron job which does daily builds/automated
David> tests off of Linus tree.  If something breaks, the person doing
David> this could perhaps come up with a minimal patch which gets
David> Linus' tree to build again (and submit a patch to the
David> appropriate maintainer, with cc to the linux-ia64 list).  I
David> plan on continuing to put out roughly monthly ia64-specific
David> patches and during those normal cycles, I'd then integrate the
David> "quick fix up" patches as needed.  Does this sound reasonable?
David> Anybody want to volunteer for this "Linus watchdog" role?

We can do this.  We're tracking Linus's tree anyway for the work we're
doing.  

  We'd probably do daily automated builds to check that the kernel
still compiles cleanly for HPSIM, DIG, and ZX1, but test only weekly.

If you have anyu specific configuration options you think should be
included, let us know.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
