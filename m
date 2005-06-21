Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVFURWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVFURWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFURWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:22:34 -0400
Received: from hq.tensilica.com ([65.205.227.29]:57038 "EHLO
	mailapp.tensilica.com") by vger.kernel.org with ESMTP
	id S262201AbVFURVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:21:02 -0400
Message-ID: <42B84C6F.4090005@tensilica.com>
Date: Tue, 21 Jun 2005 10:20:47 -0700
From: Chris Zankel <zankel@tensilica.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: xtensa architecture (-mm -> 2.6.13 merge status)
References: <20050620235458.5b437274.akpm@osdl.org>
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> xtensa architecture
> 
>     Is xtensa now, or will it be in the future a sufficiently popular
>     architecture to justify the cost of having this code in the tree?
> 
>     Heaven knows.  Will merge.

Andrew,

I understand your concern and am glad that you give Xtensa and the other 
smaller non-mainstream architectures a chance.

The Xtensa architecture is highly configurable and usually buried inside 
an SOC device. So, if you buy a new printer, digital camera, or cell 
phone, there is a chance that there is an Xtensa inside even though you 
don't know it (sometimes as a small audio-engine or as a control CPU). 
Linux hasn't been adopted widely with Xtensa yet, but with Linux growing 
in the embedded space, I am sure it will become much more important -- 
at least this is where I bet my time (and spare time) on.
 
          To minimize the impact on other developers, I do understand 
that changes that affect all architectures will only be applied to the 
mainstream architectures and that the maintainers of the non-mainstream 
architectures then have to pick it up. Luckily, the architecture 
dependent files have their own confined space in the arch and asm 
directories.

In my opinion, as long as an architecture, driver, etc. is maintained 
and not obviously obsolete, it should be allowed to remain in the 
kernel.

I do have a few small patches in the queue but am struggling with some 
changes I want to make to the syscalls that might break some older code. 

 
                     Thanks, 
                              ~Chris 
 
 
 
 
 
 
 

 

