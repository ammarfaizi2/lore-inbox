Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268211AbUHFRZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268211AbUHFRZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHFRWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:22:34 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:30441 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268192AbUHFRUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:20:04 -0400
Message-ID: <4113BDC0.6050604@tungstengraphics.com>
Date: Fri, 06 Aug 2004 18:20:00 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
References: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
In-Reply-To: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> --- Keith Whitwell <keith@tungstengraphics.com> wrote:
> 
>>Ian Romanick wrote:
>>
>>>Jon Smirl wrote:
>>>
>>>
>>>>The only case I see a problem is when drm-core is compiled into
>>>>the kernel. Why don't we just change the Makefile to default to
>>>>copying the CVS code into the kernel source tree and tell the 
>>>>user to rebuild his kernel? 
>>>
>>>
>>>I don't think that will fly with Joe-user that just wants to
>>>upgrade his graphics driver.  The other problem case is if the 
>>>user has two graphics cards in his system.  He wants to upgrade
>>>the driver for one of them (or install a new driver for a new 
>>>card), but the interface between the device-independent 
>>>(in-kernel) layer and the device-dependent (in-kernel) layer 
>>>has changed.
> 
> 
> fbdev is in exactly this model and it isn't causing anyone problems.
> The simple rule is that if you want to upgrade fbdev past the current
> version you have to do it in entirety. You do that for fbdev but
> pulling bk://fbdev.bkbits.net/. But Joe user doesn't do that, that is
> something only developers do.
> 
> Distributions release new kernels all of the time. If Joe wants to
> upgrade he graphics driver he should wait until we push it into the
> kernel and it arrives via his distribution. If he really wants to be
> bleeding edge he can copy the entirety of the DRM CVS into his kernel
> tree. 
> 
> Linux doesn't have a stable driver binary interface. It isn't meant for
> you to be able to upgrade one module while keeping the core and an
> older module.
> 
> The key here is that distributions release new kernels at a rapid pace.
> This is not X where we get a new release every five years. The standard
> mechanism for upgrading device drivers in Linux is to add them to the
> kernel and wait for a release.  If DRM uses that mechanism for
> distribution we won't have problems.

Sorry, I don't buy it.  Graphics drivers are a special case and people upgrade 
them with a passion...  No new interfaces, thankyou.

Keith

