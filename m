Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVGVXYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVGVXYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVGVXWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:22:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24587 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262220AbVGVXWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:22:31 -0400
Date: Sat, 23 Jul 2005 01:22:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Martin MOKREJ <mmokrejs@ribosome.natur.cuni.cz>,
       Mark Nipper <nipsy@bitgnome.net>, linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel version
Message-ID: <20050722232223.GC3160@stusta.de>
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722021046.GB21727@king.bitgnome.net> <42E05C17.2000305@ribosome.natur.cuni.cz> <42E05CAB.9020703@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E05CAB.9020703@linuxwireless.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 09:40:43PM -0500, Alejandro Bonilla wrote:
>...
>    How does one check if hotplug is working better than before? How do 
> I test the fact that a performance issue seen in the driver is now fixed 
> for me or most of users? How do I get back to a bugzilla and tell that 
> there is a bug somewhere when one can't really know if that is the way 
> it works but is simply ugly, or if there is really a bug?
> 
>    My point is that a user like me, can't really get back to this 
> mailing list and say "hey, since 2.6.13-rc1, my PCI bus is having an 
> additional 1ms of latency" We don't really have a process to follow and 
> then be able to say "ahha, so this is different" and then report the 
> problem, even if we can't fix it because of our C and kernel skills.
> 
>    How do we know that something is OK or wrong? just by the fact that 
> it works or not, it doesn't mean like is OK.
> 
> There has to be a process for any user to be able to verify and study a 
> problem. We don't have that yet.

If the user doesn't notice the difference then there's no problem for 
him.

If there's a problem the user notices, then the process is to send an 
email to linux-kernel and/or open a bug in the kernel Bugzilla and 
follow the "please send the output of foo" and "please test patch bar" 
instructions.

What comes nearest to what you are talking about is that you run LTP 
and/or various benchmarks against every -git and every -mm kernel and 
report regressions. But this is sinply a task someone could do (and I 
don't know how much of it is already done e.g. at OSDL), and not 
something every user could contribute to.

> .Alejandro

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

