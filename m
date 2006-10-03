Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbWJCVDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbWJCVDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWJCVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:03:48 -0400
Received: from www.osadl.org ([213.239.205.134]:42452 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030545AbWJCVDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:03:47 -0400
Subject: Re: [patch] dynticks core: Fix idle time accounting
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <1159905750.1386.215.camel@localhost.localdomain>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
	 <1159796582.1386.9.camel@localhost.localdomain>
	 <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
	 <1159814606.1386.52.camel@localhost.localdomain>
	 <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu>
	 <1159824158.1386.77.camel@localhost.localdomain>
	 <200610022135.k92LZHCn008618@turing-police.cc.vt.edu>
	 <1159905750.1386.215.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 23:05:57 +0200
Message-Id: <1159909557.1386.218.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 22:02 +0200, Thomas Gleixner wrote:
> I found a way to fix my thinkos. I put up a queue with all fixes to:
> 
> http://www.tglx.de/projects/hrtimers/2.6.18-mm3/patch-2.6.18-mm3-hrt-dyntick1.patches.tar.bz2
> 
> Can you please verify if it makes your problem go away ?

Please use dyntick2, as #1 is missing a fix. Sorry.

	tglx


