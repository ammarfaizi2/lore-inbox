Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVLMWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVLMWcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVLMWcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:32:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030301AbVLMWcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:32:04 -0500
Date: Tue, 13 Dec 2005 23:32:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, dhowells@redhat.com,
       torvalds@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213223203.GV23349@stusta.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213010126.0832356d.akpm@osdl.org> <20051213090517.GQ23384@wotan.suse.de> <20051213221810.GU23349@stusta.de> <20051213222543.GY23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213222543.GY23384@wotan.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:25:43PM +0100, Andi Kleen wrote:
> > 3.2+ would be better than 3.1+
> > 
> > Remember that 3.2 would have been named 3.1.2 if there wasn't the C++
> > ABI change, and I don't remember any big Linux distribution actually 
> > using gcc 3.1 as default compiler.
> 
> Yes, but the kernel doesn't use C++ and afaik other than that there were only
> a few minor bugfixes between 3.1 and 3.2. So it doesn't make any
> difference for this special case.

gcc 3.2.3 is four bugfix releases and nine months later than 3.1.1, and 
there are virtually no gcc 3.1 users.

It's not a strong opinion, but if the question is whether to draw the 
line before or after gcc 3.1 I'd vote for dropping gcc 3.1 support.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

