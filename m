Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWIGK1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWIGK1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWIGK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:27:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46344 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751356AbWIGK1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:27:42 -0400
Date: Thu, 7 Sep 2006 12:27:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060907102740.GH25473@stusta.de>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de> <20060907063049.GA15029@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907063049.GA15029@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 07:30:49AM +0100, Russell King wrote:
>...
> ... and maybe you should copy linux-arch with architecture-wide changes
> so that all architecture maintainers are aware of what you're trying to
> do?
>...

Andis patch "x86_64: Don't define string functions to builtin" (sic) 
that removed -ffreestanding for all architectures except i386 and that 
broke at least two architectures was neither sent to linux-arch nor to 
linux-kernel.

And I'm getting bashed for sendind a patch to revert it "only" to 
linux-kernel...

> Russell King

cu
Adrian
(who has just deleted all his cross compilers for getting rid of all 
 these troubles)

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

