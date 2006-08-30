Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWH3Rpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWH3Rpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWH3Rpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:45:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8466 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751245AbWH3Rpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:45:49 -0400
Date: Wed, 30 Aug 2006 19:45:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
       jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org,
       chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Message-ID: <20060830174547.GH18276@stusta.de>
References: <200608281003.02757.ak@suse.de> <200608281642.21737.ak@suse.de> <20060828154634.GA3450@stusta.de> <200608281900.10191.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608281900.10191.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 07:00:09PM +0200, Andi Kleen wrote:
> 
> > This would only be required if you'd upgrade the userspace kernel
> > headers on this system to a version not matching the ones glibc was
> > built against - and this has never been considered a good idea
> > (it should work in theory, but not with our current header mess).
> 
> Sorry, but that's just utterly wrong. It has always worked. The kernel ABI
> is stable on this level.

In this area, the ABI is much more stable than the API.

Try compiling glibc-2.0.1 with 2.6.17 kernel headers...

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

