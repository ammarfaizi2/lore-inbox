Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbUKDUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUKDUwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUKDUuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:50:25 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42116 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262427AbUKDUps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:45:48 -0500
Message-ID: <418A9593.5070102@tmr.com>
Date: Thu, 04 Nov 2004 15:48:19 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Heath <doogie@debian.org>
CC: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
References: <20041103233029.GA16982@taniwha.stupidest.org><20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
In-Reply-To: <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Heath wrote:
> On Wed, 3 Nov 2004, Chris Wedgwood wrote:
> 
> 
>>On Wed, Nov 03, 2004 at 05:06:56PM -0600, Adam Heath wrote:
>>
>>
>>>You can't be serious that this is a problem.
>>
>>try it, say gcc 2.95 vs gcc 4.0 ... i think last i checked the older
>>gcc was over twice as fast
> 
> 
> I didn't deny the speed difference of older and newer compilers.
> 
> But why is this an issue when compiling a kernel?  How often do you compile
> your kernel?

Twice for each -bk to look for "not my fault" issues (preempt and not), 
usually once with some combination of Nick, Con, or Ingo patches, and 
then with config options depending on what's been added. Not to mention 
patches I cull from here and my own set of network patches.

For some people I bet the limit is 24/{compile_time} per day.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
