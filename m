Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCGEKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCGEKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVCGEKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:10:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:2697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVCGEKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:10:07 -0500
Message-ID: <422BD157.6040304@osdl.org>
Date: Sun, 06 Mar 2005 19:58:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>
CC: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11.1
References: <200503050116.10577.shawn.starr@rogers.com> <20050306050649.GC11889@kroah.com> <200503062302.00040.shawn.starr@rogers.com>
In-Reply-To: <200503062302.00040.shawn.starr@rogers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> Sure, I can do this.  Wrt to trivial patches, will these patches that go into 
> rusty's patch bot go into Linus's tree or into the -mm tree? 
> 
> The reason I ask that is because a trivial patch may fix an oops if there's an 
> off-by-one problem and typically I'd submit that to the trivial patch bot.

No offense intended, but Rusty's trivial bot is often too slow
for critical patches, so trivial-but-critical would be better off
going to thru the x.y tree IMO.

> That's why I was wondering about why this tree doesn't except trivial changes.

It will if they fix real problems that people are experiencing.

The trivil bot and/or kernel-janitors paths for patches are better
used for slow/non-critical patches, not patches that need quick
attention and merging.

> Thanks,
> Shawn.
> 
> 
> On March 6, 2005 00:06, you wrote:
> 
>>On Sat, Mar 05, 2005 at 01:16:10AM -0500, Shawn Starr wrote:
>>
>>>Sounds great, I can be a QA resource for what machines I have.
>>>
>>>How do people get involved in QAing these releases?
>>
>>Get the last release and test it out.  If you have problems, and have
>>simple/obvious patches, send them on.

-- 
~Randy
