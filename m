Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263317AbUJ2NWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbUJ2NWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbUJ2NWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:22:21 -0400
Received: from mail.tmr.com ([216.238.38.203]:46737 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S263317AbUJ2NTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:19:34 -0400
Message-ID: <4182436B.20600@tmr.com>
Date: Fri, 29 Oct 2004 09:19:39 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       "michael@optusnet.com.au" <michael@optusnet.com.au>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Massimo Cetra <mcetra@navynet.it>, Ed Tomlinson <edt@aei.ca>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: My thoughts on the "new development model"
References: <200410280907_MC3-1-8D5A-FF57@compuserve.com> <20041028150329.GK12934@holomorphy.com>
In-Reply-To: <20041028150329.GK12934@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Thu, 28 Oct 2004 at 00:13:44 -0700 William Lee Irwin III wrote:
> 
>>>I'd expect vastly less than 1%, starting from the arch count, and then
>>>making some conservative guesses about drivers. Drivers probably
>>>actually take it down to far, far less than 1%.
> 
> 
> On Thu, Oct 28, 2004 at 09:04:41AM -0400, Chuck Ebbert wrote:
> 
>>  Sure, but pretty much each installation uses a different 1%.
>>  If there's a bug in there it's bound to hit someone; that's
>>what makes OS writing so difficult.  (And that's why "It works
>>for me" is not really a useful statement about the overall quality
>>of an operating system.)
> 
> 
> 99.99% of users use one arch, i386.
> 99.99% of users use one disk driver, IDE.
> The intersection of these users is probably well over 99.999% of all
> users.
> 
> Then probably a small list of secondary drivers varies. Statistically,
> users with anything but the crappiest x86 s**tboxen and a tiny subset
> of all drivers (arjan's 20) are hopelessly outnumbered.

Sorry, i386 is really a pool of Pentium, Athlon, and Opteron chips, with 
a witches brew of HT, 64bit extensions to 32 bit chips, and the like. 
Connected by a constantly changing set of Intel, SiS, VIA and other 
shipsets, and getting storage from IDE and SATA drives.

Not to mention using a vast array of CD and DVD drives and several major 
flavors of USB methods with minor variations of each, and driving their 
consoles with at least a half-dozen popular video chipsets with drivers 
of various shades of openness.

You don't even reach 99.99% with small-endian, there are more assorted 
RISC chips in use than that. I guess you're safe with twos complement 
arithmetic, although I cringed at Linus' recent "find a power of two" 
code which depends on it.  Diversity, thy name is Linux!

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
