Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752062AbWG2T3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWG2T3n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWG2T3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:29:43 -0400
Received: from mail.tmr.com ([64.65.253.246]:56743 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1752062AbWG2T3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:29:42 -0400
Message-ID: <44CBB7F5.1080704@tmr.com>
Date: Sat, 29 Jul 2006 15:33:09 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Building the kernel on an SMP box?
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com> <p73wt9x4zay.fsf@verdi.suse.de>
In-Reply-To: <p73wt9x4zay.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "Brian D. McGrew" <brian@visionpro.com> writes:
>> So, to ask the group that should know the best ... What would be a
>> reasonable configuration to get my builds down under five minutes or so?
>> And then to go to the extreme, what kind of horsepower should I be
>> looking for if I want get the build times down to say a minute or so???
> 
> Depending on your build pattern you can likely speed up rebuilds by
> using ccache. 
> 
> If that doesn't help get one or two (or more as needed) cheap dual
> core systems and use icecream (http://en.opensuse.org/Icecream) to do
> a cluster build and build with -jN (N=2*available cores/threads or so)

That sounds really useful, although I bet it assumes that the build 
environment is the same on all machines. Or at least similar. I'll have 
to try that, I have two lightly used machines to add to the build. Thanks!

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
