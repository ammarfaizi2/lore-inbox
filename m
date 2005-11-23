Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVKWQmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVKWQmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVKWQmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:42:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:13036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932070AbVKWQmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:42:31 -0500
Date: Wed, 23 Nov 2005 17:42:30 +0100
From: Andi Kleen <ak@suse.de>
To: Pete Harlan <harlan@artselect.com>
Cc: Andi Kleen <ak@suse.de>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-git latest build broken on UP x86-64
Message-ID: <20051123164230.GH20775@brahms.suse.de>
References: <20051122190202.40efabfb@localhost.localdomain> <20051123031104.GC20775@brahms.suse.de> <20051123154949.GA9271@artselect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123154949.GA9271@artselect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:49:49AM -0600, Pete Harlan wrote:
> On Wed, Nov 23, 2005 at 04:11:04AM +0100, Andi Kleen wrote:
> > On Tue, Nov 22, 2005 at 07:02:02PM -0800, Stephen Hemminger wrote:
> > > This looks new, it happens on Fedora Core 4 with UP x86-64.
> > > 
> > > arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: ???ipi_handler??? undeclared (first use in this function)
> > > arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: (Each undeclared identifier is reported only once
> > > arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.c:225: error: for each function it appears in.)
> > > make[2]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr/main.o] Error 1
> > > make[2]: Target `__build' not remade because of errors.
> > > make[1]: *** [arch/x86_64/kernel/../../i386/kernel/cpu/mtrr] Error 2
> > > 
> > > arch/x86_64/kernel/nmi.c:155: error: ???nmi_cpu_busy??? undeclared (first use in this function)
> > > arch/x86_64/kernel/nmi.c:155: error: (Each undeclared identifier is reported only once
> > > arch/x86_64/kernel/nmi.c:155: error: for each function it appears in.)
> > > make[1]: *** [arch/x86_64/kernel/nmi.o] Error 1
> > > make[1]: Target `__build' not remade because of errors.
> > > make: *** [arch/x86_64/kernel] Error 2
> > 
> > Works for me with -git2 and defconfig changed to UP. config please and last changeset.
> > 
> > -Andi
> 
> Fails here too after a "git pull" this morning.  Last changeset is:

Andrew already fixed it I believe.
-Andi
