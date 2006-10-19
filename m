Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161435AbWJSOu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbWJSOu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJSOu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:50:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:9375 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161435AbWJSOuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:50:52 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
Date: Thu, 19 Oct 2006 16:50:25 +0200
User-Agent: KMail/1.9.3
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mingo@elte.hu, tglx@linutronix.de
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net> <200610191626.10662.ak@suse.de> <45379031.601@yahoo.com.au>
In-Reply-To: <45379031.601@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191650.25678.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 16:48, Nick Piggin wrote:
> Andi Kleen wrote:
> >>An SMP kernel can boot on UP hardware, in which case I think
> >>num_possible_cpus() will be 1, won't it?
> > 
> > 
> > 0 was a typo, i meant 1 for UP of course. 0 would be nonsensical.
> 
> Sure, I realised that. For a UP kernel, the test will compile away.
> 
> But Daniel seems to say there is dead code that could be compiled
> out for SMP kernels. I just don't think that is possible because the
> SMP kernel can boot a UP system where num_possible_cpus() is 1.

I thought he meant !CONFIG_SMP kernels.

-Andi
