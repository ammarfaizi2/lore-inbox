Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTDQS1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTDQS1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:27:09 -0400
Received: from watch.techsource.com ([209.208.48.130]:38394 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261860AbTDQS1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:27:08 -0400
Message-ID: <3E9EF729.4000101@techsource.com>
Date: Thu, 17 Apr 2003 14:49:13 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
References: <200304041203_MC3-1-3302-C615@compuserve.com> <20030417142020.GB23277@waste.org> <3E9EC71B.5000901@techsource.com> <20030417160530.GD23277@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Mackall wrote:

>  
>
>>>      
>>>
>>What's ugly about them? 
>>    
>>
>
>It doesn't pass the test of "would I use it if I didn't think it was
>faster?"
>
>As I pointed out, your variant is not faster with a reasonable
>compiler, only less obvious. And none of this sort of optimization
>will ever be measurably better in the IO path anyway. But every one of
>these false optimizations is a barrier to the understanding that will
>allow real cleanups to make fundamental improvements.
>
>  
>
Agreed, but in this case, it's simply a matter of culture.  If some of 
these things were more common, then they would pass the test, like the 
use of "!!".

One thing for your side of the argument is that if something works, 
don't mess with it and risk breaking it, especially if it has no 
practical impact on performance.

If we really wanted to improve readability, we could start doing 
something like Windows developers are so fond of doing and use Hungarian 
Notation.  I know it's ugly, and we eschew anything to do with 
Microsoft, but once you get used to it, it can be very helpful in 
keeping things straight.


