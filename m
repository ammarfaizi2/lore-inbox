Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbUKSM1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUKSM1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKSMYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:24:36 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:10454 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261372AbUKSMH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:07:29 -0500
Date: Fri, 19 Nov 2004 13:05:49 +0100
From: Andi Kleen <ak@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119120549.GD21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100865050.21273.376.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:50:50AM +0000, David Woodhouse wrote:
> On Fri, 2004-11-19 at 12:55 +0100, Andi Kleen wrote:
> > On Fri, Nov 19, 2004 at 11:28:20AM +0000, David Woodhouse wrote:
> > > Can you show some examples? We don't have this for any other
> > > architecture.
> > 
> > Just grep for any use of X86 in Kconfig.
> 
> OK, I'll pick the first I find...
> 
> config ATP
>         tristate "AT-LAN-TEC/RealTek pocket adapter support"
>         depends on NET_POCKET && ISA && X86
> 
> Why is that OK on x86_64 but not Alpha? Why isn't the use of X86 a bug
> in that case?

I don't know details about the driver, but it's not enabled on x86-64 
because x86-64 doesn't have ISA set.

-Andi
