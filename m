Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVFXMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVFXMnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVFXMja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:39:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39616 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262169AbVFXMjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:39:19 -0400
Date: Fri, 24 Jun 2005 14:39:15 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding what change broke ARM
Message-ID: <20050624123914.GA5393@pasky.ji.cz>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624101951.B23185@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Jun 24, 2005 at 11:19:51AM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> When building current git for ARM, I see:
> 
>   CC      arch/arm/mm/consistent.o
> arch/arm/mm/consistent.c: In function `dma_free_coherent':
> arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
> arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
> arch/arm/mm/consistent.c:357: error: for each function it appears in.)
> make[2]: *** [arch/arm/mm/consistent.o] Error 1
> 
> How can I find what change elsewhere in the kernel tree caused this
> breakage?
> 
> With bk, you could ask for a per-file revision history of the likely
> candidates, and then find the changeset to view the other related
> changes.
> 
> With git... ?  We don't have per-file revision history so...

With Cogito, you can pass cg-log list of files, and it will show only
the history of the given files.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
