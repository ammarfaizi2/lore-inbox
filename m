Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbUKSBX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbUKSBX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbUKSBXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:23:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6408 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263034AbUKSBTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:19:13 -0500
Date: Fri, 19 Nov 2004 02:19:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119011908.GB6589@stusta.de>
References: <20041119005117.GM4943@stusta.de> <419D48DE.6030703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419D48DE.6030703@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 12:14:06PM +1100, Nick Piggin wrote:
> Adrian Bunk wrote:
> 
> >And if you want to support both older and more recent kernels, the 
> >following dependencies will be correct both before and after this 
> >change:
> >- (X86 && !X86_64)
> >- (X86 && X86_64)
> >
> 
> This last one surely can't be correct before *and* afterwards. But even in
> the current system, it is a pretty perverse thing to check for. I guess you
> meant:
> 
> (X86 || X86_64)

Yes, thanks for the correcting my typo.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

