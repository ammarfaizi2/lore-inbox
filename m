Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWHXQJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWHXQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWHXQJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:09:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60178 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030292AbWHXQJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:09:28 -0400
Date: Thu, 24 Aug 2006 18:09:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824160926.GM19810@stusta.de>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156435216.3012.130.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 05:00:16PM +0100, David Woodhouse wrote:
> On Thu, 2006-08-24 at 17:58 +0200, Adrian Bunk wrote:
> > There's no reason for getting linux-kernel swamped with
> > "my kernel doesn't boot" messages by people who accidentally disabled 
> > this option.
> 
> By that logic, you should make it necessary to set CONFIG_EMBEDDED
> before you can set CONFIG_EXT3 != Y or CONFIG_IDE != Y too.

That's the difference between Aunt Tillie and a system administrator:
A system administrator knows which filesystems he wants to use.

> However you dress it up, it's pandering to someone who either lacks the
> wit, or just can't be bothered, to _look_ at what they're doing when
> they configure their kernel. And it's a bad thing.

We already have too many user visible options and too many ways for 
people to create non-working kernels.

There's no need for additional traps.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

