Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVKAOQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVKAOQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVKAOQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:16:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51474 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750803AbVKAOP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:15:59 -0500
Date: Tue, 1 Nov 2005 15:15:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       ak@suse.de, rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051101141554.GQ8009@stusta.de>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org> <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 04:13:22PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 31 Oct 2005, Andrew Morton wrote:
> > 
> > Are you sure these kernels are feature-equivalent?
> 
> They may not be feature-equivalent in reality, but it's hard to generate 
> something that has the features (or lack there-of) of old kernels these 
> days. Which is problematic.
>...

There's also the question how to define feature-equivalent.

I want my computer to power off after "halt".

There's a significant difference between how much kernel code was 
required for this feature for my old computer and what is required for 
my new computer (in kernel 2.6.14):

   text    data     bss     dec     hex filename
  12721    2124     104   14949    3a65 arch/i386/kernel/apm.o
 136789    5724    4788  147301   23f65 drivers/acpi/built-in.o

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

