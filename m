Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbVHZNSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbVHZNSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbVHZNSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:18:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39437 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751553AbVHZNR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:17:59 -0400
Date: Fri, 26 Aug 2005 15:17:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Message-ID: <20050826131750.GG6471@stusta.de>
References: <2230.192.167.206.189.1124721719.squirrel@new.host.name> <20050822154111.4058.qmail@web33304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822154111.4058.qmail@web33304.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 08:41:11AM -0700, Danial Thom wrote:
>...
> 
> The issue I have with that logic is that you seem
> to use "kernel" in a general sense without regard
> to what its doing. Dropping packets is always
> detrimental to the user regardless of what he's
> using the computer for. An audio stream that
> drops packets isn't going to be "smooth" at the
> user level.


That's not always true.

Imagine a slow computer with a GBit ethernet connection, where the user 
is downloading files from a server that can utilize the full 
network connection while listening to music from his local disk with 
XMMS.

In this case, the audio stream is not depending on the network 
connection. And the user might prefer dropped packages over a stuttering 
XMMS.


> All of this aside, I need to measure the raw
> capabilities of the kernel. With 'bsd OSes I can
> tell what the breaking point is by driving the
> machine to livelock. Linux seems to have a soft,
> floating capacity in that it will drop packets
> here and there for no isolatable reason. I'm
> having difficulty making a case for its use in a
> networking appliance, as dropped packets are not
> acceptable. How do I tune the "its ok to drop
> packets when x occurs" algorithm to be "its never
> ok to drop packets unless x occurs" (such as a
> queue depth)? Is it possible?


What do you want to achieve with this thread?
1. Try to proof that Linux is inferior to *BSD?
2. Get help with your problem?


If your goal is 1. feel free to do so, but please do so on more 
appropriate lists.


If your goal is 2., you must help the people who are trying to help you 
with _your_ problem.

E.g. Patrick McHardy asked you:

<--  snip  -->

In that case please send more information, like both 2.4
and 2.6 configs, dmesg output from booting, lspci output,
other hardware details, ..

<--  snip  -->

Crystal balls are rare, and if your goal is really to get problem solved 
you should send the information other people require for debugging your 
problem.


> Danial

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

