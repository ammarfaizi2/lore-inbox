Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264862AbUEVCHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbUEVCHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUEVCEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:04:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8701 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264843AbUEVCDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:03:39 -0400
Date: Wed, 19 May 2004 22:16:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040519201639.GF24287@fs.tum.de>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <40A92D15.2060006@am.sony.com> <20040519152706.GD22742@fs.tum.de> <40AB925C.50001@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AB925C.50001@am.sony.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 09:59:08AM -0700, Tim Bird wrote:
> 
> First, I'll point out that this spec, as you noted, is still
> a work in progress.
> 
> Yes, the rationale is wrong.  Thanks for pointing that out.
> I'll get it fixed before we release a spec on this.  We have
> a separate agenda item in our size working group to look at
> inline expansions (See section 7.9.3 where it lists candidate
> projects that are not started yet.) There is already valuable
> work going on in the area of inline reduction, but
> unfortunately, we don't have anything to contribute to that
> discussion yet.

The main problem seems to be that you write much paper instead of 
simply writing and testing code.

Your approach might be a good solution for big projects, but if the 
changes are relatively simple it's not very useful.

> As for the patch, you are correct that the kernel makefile system
> supports compilation with -Os, and someone besides us submitted
> the patch for that.  However, there is more work needed to
> validate that the option doesn't break things, on many different
> architectures.
> 
> I have reports from the uClinux crowd that use of
> the -Os option is fairly typical for users of uClinux, and they
> have no reports of breakage.  However, we want to take a methodical
> approach to validating that use of this option is fully supported
> by the Linux kernel.  Also, we want to test and report the size
> and performance effects of the use of the flag.  This work is
> not done yet, so the spec. is still under construction.
>...

If you'd have asked people knowing the code (e.g. by sending an email to 
linux-kernel), you'd have already known:
- the ARM port always uses -Os in kernel 2.4
- the ACPI code is always compiled with -Os in kernel 2.4
- part of the ARM port always uses -Os with "recent" gcc in
  kernel 2.2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

