Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTIBRt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTIBRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:49:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263913AbTIBRoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:44:44 -0400
Date: Tue, 2 Sep 2003 18:44:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_64_BIT
Message-ID: <20030902174436.GP13467@parcelfarce.linux.theplanet.co.uk>
References: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73wucrm6uo.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wucrm6uo.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:35:11PM +0200, Andi Kleen wrote:
> Matthew Wilcox <willy@debian.org> writes:
> 
> > What do people think of CONFIG_64_BIT?  It saves us from using
> > !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> 
> For Kconfigs it may make sense, but is there any Config rule that 
> checks for all 64bit archs (opposed to checking for specific archs)?
> I cannot thinkg of any.

... that was what the patch added.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 07:35:11PM +0200, Andi Kleen wrote:
> Matthew Wilcox <willy@debian.org> writes:
> 
> > What do people think of CONFIG_64_BIT?  It saves us from using
> > !(IA64 || MIPS64 || PARISC64 || S390X || SPARC64 || X86_64) or
> 
> For Kconfigs it may make sense, but is there any Config rule that 
> checks for all 64bit archs (opposed to checking for specific archs)?
> I cannot thinkg of any.

... that was what the patch added.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
