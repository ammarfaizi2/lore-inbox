Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVKJKaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKJKaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKJKaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:30:46 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:60087 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750742AbVKJKap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:30:45 -0500
Date: Thu, 10 Nov 2005 11:29:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/39] NLKD/i386 - core adjustments
Message-ID: <20051110102936.GA5376@stusta.de>
References: <43720FBA.76F0.0078.0@novell.com> <43720FF6.76F0.0078.0@novell.com> <43721024.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <43721119.76F0.0078.0@novell.com> <43721142.76F0.0078.0@novell.com> <43721184.76F0.0078.0@novell.com> <437211B6.76F0.0078.0@novell.com> <20051109190017.GB4047@stusta.de> <43730D3A.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43730D3A.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 09:04:58AM +0100, Jan Beulich wrote:
> >>> Adrian Bunk <bunk@stusta.de> 09.11.05 20:00:17 >>>
> >On Wed, Nov 09, 2005 at 03:11:51PM +0100, Jan Beulich wrote:
> >> The core i386 NLKD adjustments to pre-existing code.
> >> 
> >> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> >> 
> >> (actual patch attached)
> >
> >If your code doesn't work with 4k stacks you have a problem because
> >8k stacks will soon be removed (my goal is 2.6.16, perhaps one or two
> 
> >releases later).
> 
> It's not that it doesn't work with them, but chances of stack overflow
> are too high for my taste.

If there's a chance of a stack overflow the stack usage has to be 
reduced until the chance goes down to 0.

> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

