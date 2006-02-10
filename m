Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWBJAFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWBJAFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWBJAFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:05:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25861 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750841AbWBJAFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:05:24 -0500
Date: Fri, 10 Feb 2006 01:05:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup possibility in asm-i386/string.h
Message-ID: <20060210000523.GE3524@stusta.de>
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071230520.9696@scrub.home> <200602071308.59827.ak@suse.de> <Pine.LNX.4.61.0602071336060.30994@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602071336060.30994@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 01:39:50PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 7 Feb 2006, Andi Kleen wrote:
> 
> > > This means you define a prototype for the builtin function and not for the 
> > > normal function. I'm not sure this is really intended.
> > 
> > What good would be a prototype for a symbol that is defined to a different symbol?
> 
> The point is you define a prototype for a builtin function, I'm not sure 
> that's a good thing to do.
> Actually I'd prefer to remove -ffreestanding again, especially because it
> disables builtin functions, which we have to painfully enable all again 
> one by one, instead of leaving it just to gcc.

I remember playing with using more gcc builtins in the kernel some time 
ago, and some gcc builtin used a different library function, which was a 
function the kernel did not supply.

I don't remember the exact details, but this was the reason why I 
preferred using builtins only when explicitely enabled.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

