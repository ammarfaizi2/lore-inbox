Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754075AbWKVO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbWKVO6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbWKVO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:58:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12292 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1754075AbWKVO6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:58:02 -0500
Date: Wed, 22 Nov 2006 15:58:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: d binderman <dcb314@hotmail.com>, linux-kernel@vger.kernel.org,
       mel@csn.ul.ie
Subject: Re: arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was set but nev
Message-ID: <20061122145801.GH5200@stusta.de>
References: <BAY107-F11C5D88BF00FBB291F3FC09CE30@phx.gbl> <p73mz6j8xdv.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mz6j8xdv.fsf@bingen.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:43:40PM +0100, Andi Kleen wrote:
> "d binderman" <dcb314@hotmail.com> writes:
> 
> > Hello there,
> > 
> > I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> > C compiler.
> > 
> > The compiler said
> > 
> > arch/x86_64/mm/numa.c(124): remark #593: variable "bootmap_size" was
> > set but never used
> 
> Actually it looks like a real bug -- probably added recently with the
> new bootmap code.

No, this unused assignment is in all 2.6 kernels starting with 2.6.0 and 
even in 2.4 .

> The bootmap should be reserved based on that size.
> 
> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

