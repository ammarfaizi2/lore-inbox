Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316963AbSEaWnm>; Fri, 31 May 2002 18:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSEaWnl>; Fri, 31 May 2002 18:43:41 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:49398 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316963AbSEaWnl>; Fri, 31 May 2002 18:43:41 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: USB host drivers test results (2.5.19) and problem.
Date: Sat, 1 Jun 2002 08:41:55 +1000
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020531133429.GF8310@come.alcove-fr> <21481.1022856842@redhat.com> <20020531150740.GG8310@come.alcove-fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206010841.55196.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jun 2002 01:07, Stelian Pop wrote:
> However, maybe even a hotplug aware driver should print out a message
> upon initialization telling 'no hardware found'... It could be useful
> when you want to know the difference between:
> 	* bad driver, use another one
> 	* good driver, but doesn't recognize/init the hardware because it's buggy.
Even if you have the driver compiled in, and there is no hotplug, you still 
don't want every driver complaining about not having suitable hardware. Think 
distribution kernels (or "kernel that handles my heterogenous lab") and 
network device drivers...

Brad


-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
