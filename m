Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWARIH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWARIH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWARIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:07:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51982 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932427AbWARIH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:07:27 -0500
Date: Wed, 18 Jan 2006 09:07:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug tracking
Message-ID: <20060118080725.GI19398@stusta.de>
References: <OFA777C944.9337E52B-ONC12570C1.0039A0E1-C12570C9.004D661A@avm.de> <20060117224433.GF19398@stusta.de> <20060117150612.345571ef.akpm@osdl.org> <20060117231153.GG19398@stusta.de> <20060117155013.27507a1b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117155013.27507a1b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 03:50:13PM -0800, Andrew Morton wrote:
>...
> So please don't let me discourage you from doing this - if a reporter gets
> multiple emails regarding a bug, he's unlikely to be offended - it's heaps
> better than zero emails!  I'll cc you in future if you like so we can avoid
> duplication.

You can Cc me, but there might be other people with the same problem.

But thinking about it, the real issue seems to be that the Linux kernel 
is the only open source project of this size I know about where bug 
reporters are not encouraged to enter all bugs in a bug tracking system 
resulting in manual work to track them.

There are classes of bugs where Bugzilla doesn't bring much ("your patch 
xyz.patch in the latest -mm breaks compilation on i386"), but for most 
bug reports it would be nice. The problem is that while some subsystem 
maintainers use the kernel Bugzilla, others don't want to use it and 
want bug reports sent to mailing lists instead.

I know that some kernel developers do not like Bugzilla, but the kernel
Bugzilla has email interfaces in both directions and it should therefore 
be possible to integrate into existing workflows without too much
overhead.

This way, the bookkeeping of bugs is done automatically, and although 
this does not automatically fix bugs I've e.g. had some cases where I 
told maintainers "please review your 19 open bugs in the kernel 
Bugzilla" resulting in maintainers actually reviewing and fixing bugs. 
This included cases where the old maintainer was inactive and a new 
maintainer has taken over maintainership.

How can we get to the state that there's a kernel bug tracking system 
every maintainer is using?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

