Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSGJRWk>; Wed, 10 Jul 2002 13:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSGJRWk>; Wed, 10 Jul 2002 13:22:40 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:24072 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S317561AbSGJRWj>; Wed, 10 Jul 2002 13:22:39 -0400
Date: Wed, 10 Jul 2002 18:25:13 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Thunder from the hill <thunder@ngforever.de>, Adrian Bunk <bunk@fs.tum.de>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       bob <bob@watson.ibm.com>, Richard Moore <richardj_moore@uk.ibm.com>
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020710172513.GB49811@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0207101027380.5067-100000@hawkeye.luckynet.adm> <3D2C66D9.AF14035A@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2C66D9.AF14035A@opersys.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17SLDI-0004dj-00*zW8GnfSIZpA* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 12:54:49PM -0400, Karim Yaghmour wrote:

> In light of the recent discussions, it would be really nice to get a
> definitive statement about LTT's inclusion in 2.5.

It has been pointed out to you at least once that it would stand a much
better chance if you were to follow the kernel coding style, for one ...

And things like :

+#ifndef CONFIG_SMP /* On an SMP machine NMIs are used to implement a watchdog and will hang
+                      the machine if traced. */
+        TRACE_TRAP_ENTRY(2, regs->eip);
+#endif
+

aren't very encouraging.

just my 2p
john

-- 
"I know I believe in nothing but it is my nothing"
	- Manic Street Preachers
