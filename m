Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWG1A6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWG1A6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWG1A6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:58:31 -0400
Received: from mail.tmr.com ([64.65.253.246]:23020 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751007AbWG1A6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:58:30 -0400
Message-ID: <44C96208.1060609@tmr.com>
Date: Thu, 27 Jul 2006 21:02:00 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Building the kernel on an SMP box?
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> Good morning all!
> 
> Currently I'm building my kernels on a Dell PE 1800 3.0GHz.  My dilemma
> is that I build and rebuild the kernel about twenty times a day and even
> though it only takes about 20 minutes, that's rapidly becoming too slow!
> Today it's the 2.6.17 kernel on FC5 that I'm building with.
> 
> I see all these blurbs out there about someone being able to build a
> complete kernel in under a minute or running an SMP build across
> multiple CPUS and/or multiple machines.
> 
> So, to ask the group that should know the best ... What would be a
> reasonable configuration to get my builds down under five minutes or so?
> And then to go to the extreme, what kind of horsepower should I be
> looking for if I want get the build times down to say a minute or so???

I can just about make it on 2xXeons at 3.0GHz, HT enabled, 4GB RAM. But 
the new "Core 2 Duo" stuff is tons faster, is dual core but no HT yet, 
has better cache, faster memory bus... costs more. Some big NUMA 
hardware after that,

I will guess the new cheap point is o/c Core 2 Duo 6700, and will finish 
in about 7 min. Patience is a virtue.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
