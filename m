Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVAFE67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVAFE67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 23:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAFE67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 23:58:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:61076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262721AbVAFE64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 23:58:56 -0500
Message-ID: <41DCC414.9060308@osdl.org>
Date: Wed, 05 Jan 2005 20:52:36 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Konrad Wojas <wojas@vvtp.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 oops in poll()?
References: <20050103161556.GD31250@vvtp.tudelft.nl> <41DB1C92.7060501@osdl.org> <20050105040841.GI31250@vvtp.tudelft.nl> <41DC30C9.5050402@osdl.org> <20050105185733.GJ31250@vvtp.tudelft.nl> <41DC3BD6.3020303@osdl.org> <20050105211109.GK31250@vvtp.tudelft.nl>
In-Reply-To: <20050105211109.GK31250@vvtp.tudelft.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Wojas wrote:
> On Wed, Jan 05, 2005 at 11:11:18AM -0800, Randy.Dunlap wrote:
> 
>>Konrad Wojas wrote:
>>
>>>On Wed, Jan 05, 2005 at 10:24:09AM -0800, Randy.Dunlap wrote:
>>>
>>>
>>>>This probably needed to use /proc/kallsyms from the dying kernel,
>>>>which you most likely don't have....
>>>>
>>>>I'm having trouble seeing what sock_poll() called (i.e., where EIP
>>>>register points to).  In the /boot/System.map-2.6.9-1-686 file,
>>>>is anything near address 0xc02b5513 listed?
>>>>(or just send me that file privately)

Sorry, I'm not getting anywhere with this.
The obvious thing is that EIP (0xc02b5513) is not pointing
to code, but to data (ASCII text, as in a file name from
the kernel source tree)...

There's not quite enough stack data for me to determine
what happened.

>>>Also doesn't look very helpfull to me..
>>
>>True.  Have you tested this problem on 2.6.10 yet?
> 
> 
> No, I don't even know how to reproduce this on 2.6.9.
> 
> 
>>Back to 2.6.9:  do you normally run 2.6.9 with all of those same
>>modules loaded?  If so, please send me the /proc/modules
>>and /proc/kallsyms files.
> 
> 
> I'm quite sure the same modules were loaded. I've sent the files by
> private mail.


-- 
~Randy
