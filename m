Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWDEOrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWDEOrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 10:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDEOrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 10:47:18 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:3347 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP
	id S1750752AbWDEOrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 10:47:18 -0400
Date: Wed, 5 Apr 2006 10:47:17 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: linux-kernel@vger.kernel.org
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
Message-ID: <20060405144716.GA10353@widomaker.com>
References: <1143510828.1792.353.camel@mindpipe> <20060327195905.7f666cb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327195905.7f666cb5.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, 27 Mar 2006 @ 19:59 -0800, Andrew Morton said:

> Much porkiness.
> 
> /proc/meminfo is very useful for obtaining a top-level view of where all
> the memory's gone to.  I'd tentatively say that your options are to put up
> with the swapping or find a new mail client.

I use mutt for my email, and I have the same issue on a 1GB system.

I really wish we could put an upper limit on what file cache can use.

I understand the original poster was running a lot of pork, but you
don't have to and still see a problem with swapping.  Even running KDE
my total application memory most of the time is 300MB or less on a
machine with 1GB of memory.

I shouldn't be suffering from swap storms.

For example, my normal working set of programs eats about 250MB of memory. If
I also start a job running to something like tag some mp3s, copy a CD, or just
process a lot of files, it only takes a few minutes before performance becomes
unacceptable.  

If you are doing some work where you switch among several applications
frequently, the pigginess of file cache becomes a serious problem.

Isn't that bad behavior by any measure?



-- 
shannon "AT" widomaker.com -- ["It's a damn poor mind that can only think
of one way to spell a word." -- Andrew Jackson]
