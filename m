Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUDZPvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUDZPvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDZPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:51:13 -0400
Received: from mail.tmr.com ([216.238.38.203]:32787 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262634AbUDZPvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:51:11 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Unable to read UDF fs on a DVD
Date: Mon, 26 Apr 2004 11:52:25 -0400
Organization: TMR Associates, Inc
Message-ID: <408D3039.6090604@tmr.com>
References: <20040423195004.GA1885@dreamland.darkstar.lan> <1082751675.3163.106.camel@patibmrh9> <20040424194727.GA3353@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1082994507 24391 192.168.12.100 (26 Apr 2004 15:48:27 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Pat LaVarre <p.lavarre@ieee.org>, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
To: kronos@kronoz.cjb.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040424194727.GA3353@dreamland.darkstar.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos wrote:
> Il Fri, Apr 23, 2004 at 02:21:15PM -0600, Pat LaVarre ha scritto: 
> 
>>P.S. Five postscripts:
>>
>>1)
>>
>>
>>>even with ide-scsi, though.
>>
>>Whoa.  You weren't engaging in the taboo act of running ide-scsi in 2.6
>>back when ls failed, were you?
> 
> 
> No, I wasn't. I'm aware that ide-scsi is not needed with 2.6. I had to
> recompile the kernel with ide-scsi to make Philips fsck happy.

I believe that it would be more correct to say that ide-scsi is not 
required to burn CDs and DVDs, providing you use cdrecord which has been 
modified to work with ide-cd. Since that's the major use it equates to 
"not needed" if that's all you do.

As you seem to note, some DVD burners don't work without ide-scsi unless 
you have some tricks and/or patches, but do work with ide-scsi. Yes, 
even in 2.6.

I totally agree you should try to run without it, but I'd compile it as 
a module in case you need some additional data points.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
