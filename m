Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVKAP0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVKAP0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 10:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKAP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 10:26:12 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:52136 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750885AbVKAP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 10:26:10 -0500
Message-ID: <4367893D.9090406@tmr.com>
Date: Tue, 01 Nov 2005 10:26:53 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: zippel@linux-m68k.org, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>	<20051031001647.GK2846@flint.arm.linux.org.uk>	<20051030172247.743d77fa.akpm@osdl.org>	<200510310341.02897.ak@suse.de>	<Pine.LNX.4.61.0511010039370.1387@scrub.home>	<20051031160557.7540cd6a.akpm@osdl.org>	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org>
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>>
>>On Mon, 31 Oct 2005, Andrew Morton wrote:
>>
>>>Are you sure these kernels are feature-equivalent?
>>
>>They may not be feature-equivalent in reality, but it's hard to generate 
>>something that has the features (or lack there-of) of old kernels these 
>>days. Which is problematic.
> 
> 
> Probably.
> 
> 
>>But some of it is likely also compilers. gcc does insane padding in many 
>>cases these days. 
> 
> 
> 2.6.14 `make allnoconfig':
> 
> gcc-2.95.4:
> 
> 	bix:/usr/src/25> size vmlinux 
> 	   text    data     bss     dec     hex filename
> 	 665502  152379   55120  873001   d5229 vmlinux
> 
> gcc version 4.1.0 20050513 (experimental):
> 
> 	bix:/usr/src/25> size vmlinux
> 	   text    data     bss     dec     hex filename
> 	 761415  151851   55280  968546   ec762 vmlinux

Was this with -Os or ???
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
