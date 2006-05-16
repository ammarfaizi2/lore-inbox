Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWEPJWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWEPJWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 05:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWEPJWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 05:22:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:62152 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751711AbWEPJWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 05:22:13 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Tue, 16 May 2006 11:22:07 +0200
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152138.57347.ak@suse.de> <20060516070612.GA14317@elte.hu>
In-Reply-To: <20060516070612.GA14317@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161122.08123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As you suggested a few weeks ago the real solution would be a dwarf 
> parser. Maybe ia64's could be taken? 

Ia64's would be a lot of work.

> (and it works fine across irq/exception stacks too.)

It didn't work at all through the old locks/semaphore stubs.

> > I think i386 only gained it very recently, so it can't be _that_ big a 
> > problem.
> 
> i certainly used exact backtraces on i386 for many many years.

The patch into mainline went in in mid 2004. 

http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=commit;h=066479e379f387e5b1da0f1149fe0b97bac58888


-Andi
