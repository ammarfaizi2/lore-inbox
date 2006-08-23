Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965286AbWHWWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbWHWWxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWHWWxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:53:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40202 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965286AbWHWWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:53:05 -0400
Date: Thu, 24 Aug 2006 00:53:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Alpha: replacing "extern inline"
Message-ID: <20060823225303.GD19810@stusta.de>
References: <20060820235438.GY7813@stusta.de> <20060821215526.GA22930@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821215526.GA22930@twiddle.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 02:55:26PM -0700, Richard Henderson wrote:
> On Mon, Aug 21, 2006 at 01:54:38AM +0200, Adrian Bunk wrote:
> > Why?
> 
> Because it inlines when it needs to, and does not generate
> out of line code when its address is taken.

Ah, I start to remember.

Is this actually used anywhere in the kernel?

> > Can someone tell me which of the Alpha "static inline"'s need for some 
> > reason an __always_inline?
> 
> There shouldn't be any.
> 
> > Does the never defined __IO_EXTERN_INLINE still have any purpose?
> 
> It is defined.
> 
> $ grep 'define __IO_EXTERN_INLINE' * | wc -l
> 12

Ups, I was blind...

> r~

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

