Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbUCJUvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUCJUvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:51:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53937 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262824AbUCJUuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:50:13 -0500
Message-ID: <404F7F54.1000105@us.ibm.com>
Date: Wed, 10 Mar 2004 14:49:24 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Rusty Russell <rusty@au1.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       kai@germaschewski.name, sam@ravnborg.org, akpm@osdl.org
Subject: Re: Question on MODULE_VERSION macro
References: <20040119214233.GF967@beaverton.ibm.com> <20040120005915.2A54A17DD8@ozlabs.au.ibm.com> <20040120011734.GB6309@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the MODULE_VERSION macro is now in the tree.
Greg, any status on the sysfs patch you mention below?

thanks,

Brian


Greg KH wrote:
> On Tue, Jan 20, 2004 at 11:57:38AM +1100, Rusty Russell wrote:
> 
>>In message <20040119214233.GF967@beaverton.ibm.com> you write:
>>
>>>Rusty,
>>>	Christoph mentioned that a MODULE_VERSION macro may be pending.
>>
>>Hey, thanks Christoph for the reminder.  I stopped when we were
>>frozen.
>>
>>This still seems to apply.  Do people think this is huge overkill, or
>>a work of obvious beauty and genius?
> 
> 
> Looks sane.  I'm guessing that modinfo can show this?
> 
> 
>>Doesn't put things in sysfs, but Greg was working on that for module
>>parameters... Greg?
> 
> 
> Oh yeah, I'll dig out that patch later this week.  An older version has
> been sitting in my bk tree forever, need to update it with the last
> changes you sent me.
> 
> thanks,
> 
> greg k-h
> 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

